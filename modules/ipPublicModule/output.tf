output "public_ip" {
  value = aws_eip.lb.id
}
