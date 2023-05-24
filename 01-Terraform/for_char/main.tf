provider "local" {
}

variable "name" {
  description = "Names to render"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "for_directive" {
  value = <<EOF
%{~for name in var.name}
	${name}
%{endfor}
EOF
}


