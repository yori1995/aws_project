variable "bucket_name" {
	description = "The name of the S3 bucket. Must be globally unique."
		type			= string
		default		= "aws07-terraform-state"
}

varialbe " table_name" {
	descriiption = "The name of the DynamoDB table. Must be unique in this AWS account."
		type 			 = string
		default    = "terraform-locks"
}

