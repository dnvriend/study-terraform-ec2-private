output "aws_instance_private_ip" {
  value = local.enable_private ? {
    private_ip : aws_instance.private[0].private_ip,
    public_ip : null,
  } : null
}

output "aws_instance_private_id" {
  value = local.enable_private ? aws_instance.private[0].id : null
}

output "aws_instance_public_ip" {
  value = local.enable_public ? {
    public_ip : aws_instance.public[0].public_ip,
    private_ip : aws_instance.public[0].private_ip
  } : null
}

output "aws_instance_public_id" {
  value = local.enable_public ? aws_instance.public[0].id : null
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}
