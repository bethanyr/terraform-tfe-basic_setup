terraform {
  required_providers {
    tfe = {
      version = "~> 0.24.0"
    }
    random = {
        version = "2.2"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
  token = var.token
}

provider "random" {

}

resource "random_pet" "org_name" {}

resource "tfe_organization" "org" {
  name  = random_pet.org.id
  email = var.email
}

resource "tfe_oauth_client" "oauth" {
  organization = tfe_organization.org.name
  api_url = "https://api.github.com"
  http_url = "https://github.com"
  oauth_token = var.oauth_token
  service_provider = "github"
}

resource "tfe_registry_module" "petstore" {
  vcs_repo {
    display_identifier = var.module_repo
    identifier = var.module_repo
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_workspace" "tfr" {
  count = var.workspace_count
  organization = var.organization
  name = "tfr${count.index}"
  auto_apply = true
  queue_all_runs = true

  vcs_repo {
    identifier = var.repo
    branch = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }

  # The terraform configuration for this set of workspaces
  # references the petstore module.
  depends_on = [
    tfe_registry_module.petstore,
  ]
}
