terraform { 
	required_version = ">= 1.0.0, < 2.0.0"

	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~>4.0"
		}
	}


#backend에 대한 정보 지정

backend "s3" {
#이전에 만든 버킷 이름으로 작성한다.
	 bucket = "aws07-terraform-state"
	 key		= "infra/ec2/terraform.tfstate"
	 region = "ap-northeast-2"

#이전에 생성한 다이나모DB 테이블 이름으로 작성한다.
	 dynamodb_table = "aws07-terraform-locks"
	 encrypt				= true
 }
}

