terraform{
  backend "s3" {
    #이전에 생성한 버킷 이름으로 변경
    bucket = "aws07-terraform-state"
    key = "infra/network/bastion/terraform.tfstate"
    region = "ap-northeast-2"

    #이전에 생성한 다이나모db 테이블 이름으로 변경
    dynamodb_table = "aws07-terraform-locks"
    encrypt = true
 }
}