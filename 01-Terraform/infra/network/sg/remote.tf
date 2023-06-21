data "terraform_remote_state" "aws07_vpc" {
    backend = "s3"
    config = {
        bucket = "aws00-terraform-state"
        key = "infra/network/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

