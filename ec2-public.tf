resource "aws_instance" "public" {
  count                       = local.enable_public ? 1 : 0
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.small"
  availability_zone           = "${data.aws_region.current.name}a"
  iam_instance_profile        = aws_iam_instance_profile.public[0].name
  key_name                    = "dnvriend"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.public[0].id]
  monitoring                  = true
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 40
    volume_type           = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y mariadb105
              sudo dnf install -y mariadb105-server
              sudo dnf install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              echo '<html><body><h1>Hello World</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "public"
  }
}

resource "aws_iam_instance_profile" "public" {
  count = local.enable_public ? 1 : 0
  name  = "public"
  role  = aws_iam_role.public[0].name
  path  = "/"
}

resource "aws_iam_role" "public" {
  count                 = local.enable_public ? 1 : 0
  name                  = "public"
  description           = "public"
  force_detach_policies = false
  max_session_duration  = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "Service" : "ec2.amazonaws.com" }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachments_exclusive" "role_policy_attachment_public" {
  count     = local.enable_public ? 1 : 0
  role_name = aws_iam_role.public[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  ]
}

resource "aws_security_group" "public" {
  count       = local.enable_public ? 1 : 0
  description = "public"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "allow-all"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    description = "allow-http"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
}
