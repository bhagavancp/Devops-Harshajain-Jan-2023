module "create_sg" {
    source = "./modules/create_sg"
    sg_name = var.root_sg_name
}

module "create_pem" {
    source = "./modules/create_pem"
    key_name = var.root_key_name
    key_path = var.root_key_path
}

module "create_ec2_2" {
    source = "github.com/jaintpharsha/terra_module.git//create_ec2"
    ec2_type = var.root_ec2_type
    ec2_pem = module.create_pem.ec2_pem
    ec2_sg_id = module.create_sg.sg_id
}

# module "create_s3" {
#     source = "./modules/create_s3"
#     bucket_name = var.root_s3_backend_name 
# }

# module "create_dynamodb" {
#     source = "./modules/create_dynamobd"
#     dynamodb_name = var.root_dynamodb_name 
#     hash_key = var.root_dynamodb_key
# }

module "file_provisioner" {
    source = "./modules/file_provisioner"
    ec2_public_ip = module.create_ec2_2.ec2_public_ip_address
    ec2_user = var.root_ec2_user
    ec2_pem =  var.root_key_path
    source_path = var.root_source_path
    destination_path = var.root_destination_path
}

module "remote_provisioner" {
    source = "./modules/remote-exec"
    ec2_public_ip = module.create_ec2_2.ec2_public_ip_address
    ec2_user = var.root_ec2_user
    ec2_pem =  var.root_key_path
}

module "local_provisioner" {
    source = "./modules/local-exec"
    ec2_public_ip = module.create_ec2_2.ec2_public_ip_address 
}
