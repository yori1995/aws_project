provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "Create IAM with these names"
  type        = list(string)
  default     = ["aws07-neo", "aws07-morpheus"]
}

output "all_arn" {
	value			  = aws_iam_user.example[*].arn
	description = "The ARN for user neo"
}
