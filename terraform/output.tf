output "aws-ip" {
  value = aws_instance.boundary-env-aws.public_ip
}
