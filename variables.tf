variable "hostname" {
  type = string
  description = "hostname for your tfe/tfc instance"
}

variable "oauth_token" {
  type = string
  description = "Go to github and create a [personal access token](https://github.com/settings/tokens/new) with the `repo` and `admin:repo_hook` scopes. Use this generated value for your `oauth_token` value in `terraform.tfvars`."
}

variable "workspace_count" {
  type = string
  default = "5"
  description = "number of workspaces to create"
}

variable "branch" {
  type = string
  default = "main"
  description = "branch used for workspace creation"
}

variable "repo" {
  type = string
  description = "path for github repo for workspace creation"
}

variable "module_repo" {
  type = string
  description = "path for github repo for sample module that will be imported to PMR"
}

variable "token" {
  type = string
  description = "token used by tfe provider for connecting to your tfe/tfc instance"
}

variable "email" {
  type = string
  description = "email address used for creating organization"
}
