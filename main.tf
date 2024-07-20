resource "cloudflare_pages_project" "this" {
  account_id        = var.cloudflare_account_id
  name              = var.cloudflare_project_name
  production_branch = var.production_branch

  source {
    type = "github"
    config {
      owner                         = var.repo.owner
      repo_name                     = var.repo.name
      production_branch             = var.production_branch
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_branch_excludes       = var.preview_branch_excludes
      preview_branch_includes       = var.preview_branch_includes
    }
  }

  build_config {
    build_command   = var.build.command
    destination_dir = var.build.artifacts_dir
    root_dir        = var.root_directory
    build_caching   = false
  }
}

resource "cloudflare_pages_domain" "this" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.this.name
  domain       = var.production_domain
}

resource "cloudflare_record" "this" {
  zone_id = var.cloudflare_zone_id
  type    = "CNAME"
  name    = var.production_domain
  value   = cloudflare_pages_project.this.subdomain
  proxied = true
  comment = var.cloudflare_record_comment
}
