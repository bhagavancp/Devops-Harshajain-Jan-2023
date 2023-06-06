resource "null_resource" "file_copy" {
    connection {
        type = "ssh"
        host = var.ec2_public_ip
        user = "${var.ec2_user}"
        private_key = file(var.ec2_pem)
        agent = false 
    }
    
    provisioner "remote-exec" {
        inline = [
          "sudo apt update -y",
          "sudo apt install jq git -y",
          "echo 'This is remote-exec example' > remote-exec.txt"
        ]
    }
}  