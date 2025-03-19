# study-terraform-ec2-private
A small project to test the AWS session manager and how to setup ssh to tunnel using ssh + sm without port 22

## SSH config

Example config:

```
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3

# SSH over Session Manager
Host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
    IdentityFile %d/.ssh/the_pem_you_launched_your_ec2_instance_with.pem
    User ec2-user
```

## Example commands

```bash
# connect to instance (does not matter if private or public subnet, port 22 disabled)
ssh i-0cada52cf6dca24b0

# port foward local port 8080 to remote port 80, does not matter if private or public subnet
ssh i-0cada52cf6dca24b0 -fNT -4 -L 8080:localhost:80

# port foward local port 3306 to remote port 3306, does not matter if private or public subnet
ssh i-0cada52cf6dca24b0 -fNT -4 -L 3306:localhost:3306
```
