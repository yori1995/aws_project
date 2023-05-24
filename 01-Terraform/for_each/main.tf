provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name  = each.value
}

variable "user_names" {
  description = "Create IAM with these names"
  type        = list(string)
  default     = ["aws07-neo","aws07-trinity","aws07-morpheus"]
}

output "all_user" {
  value       = values(aws_iam_user.example)[*].arn
  description = "The Name for user neo"
}
