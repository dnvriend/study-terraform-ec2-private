resource "aws_instance" "private" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.small"
  availability_zone           = "${data.aws_region.current.name}a"
  key_name                    = "dnvriend"
  iam_instance_profile        = aws_iam_instance_profile.private[0].name
  subnet_id                   = aws_subnet.private_1.id
  vpc_security_group_ids      = [aws_security_group.private[0].id]
  monitoring                  = true
  associate_public_ip_address = false
  count                       = local.enable_private ? 1 : 0

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 40
    volume_type           = "gp3"
  }

  # see: https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y mariadb105
              sudo dnf install -y mariadb105-server
              sudo dnf install -y nginx
              sudo dnf install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              echo '<html><body><h1>Hello World</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "private"
  }
}

resource "aws_iam_instance_profile" "private" {
  name  = "private"
  role  = aws_iam_role.private[0].name
  path  = "/"
  count = local.enable_private ? 1 : 0
}

resource "aws_iam_role" "private" {
  name                  = "private"
  description           = "private"
  force_detach_policies = false
  max_session_duration  = 3600
  count                 = local.enable_private ? 1 : 0

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

resource "aws_iam_role_policy_attachments_exclusive" "role_policy_attachment_private" {
  role_name = aws_iam_role.private[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  ]
  count = local.enable_private ? 1 : 0
}

resource "aws_security_group" "private" {
  description = "private"
  vpc_id      = aws_vpc.main.id
  count       = local.enable_private ? 1 : 0

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
