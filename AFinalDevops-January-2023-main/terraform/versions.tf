terraform {
    required_version = "~>1.4.0"

    required_providers {
        aws = {
            version = ">= 4.51.0"
        }
    }

    backend "s3" {
        bucket = "my-s3-terraform-backend-9884524"
        key = "main/terraform.tfstate"
        region = "ap-south-1"
    }
}