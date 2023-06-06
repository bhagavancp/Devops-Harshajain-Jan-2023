output "ec2_pem" {
    value = aws_key_pair.pem_file.key_name
}