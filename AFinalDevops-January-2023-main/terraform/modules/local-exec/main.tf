resource "null_resource" "name" {
    provisioner "local-exec" {
        command = "chmod 400 my_pem.pem; echo ${var.ec2_public_ip} > conf/public_ip.txt"
    }
}