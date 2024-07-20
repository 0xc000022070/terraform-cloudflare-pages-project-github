
variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_project_name" {
  type = string
}

variable "cloudflare_record_comment" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "production_domain" {
  type = string
}

variable "production_branch" {
  type    = string
  default = "main"
}

variable "repo" {
  type = object({
    owner = string
    name  = string
  })
}

variable "build" {
  type = object({
    command       = string
    artifacts_dir = string
  })
}

variable "root_directory" {
  type    = string
  default = ""
}

variable "preview_branch_includes" {
  type    = list(string)
  default = ["*"]
}

variable "preview_branch_excludes" {
  type    = list(string)
  default = []
}
