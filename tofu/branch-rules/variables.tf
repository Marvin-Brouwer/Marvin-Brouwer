variable "repository" {
  description = "Name of the repository."
  type        = string
}

variable "branch" {
  description = "Branch the ruleset protects."
  type        = string
  default     = "main"
}

variable "app_id" {
  description = "ID of the automation GitHub App. It may bypass the ruleset, to approve dependabot PRs and commit the OpenTofu state."
  type        = number
}

variable "required_checks" {
  description = "Status checks that have to pass before merging, by name as GitHub shows them. Empty means none."
  type        = list(string)
  default     = []
}

variable "required_approvals" {
  description = "Approving reviews a PR needs. Repo admins bypass this, so your own PRs don't wait."
  type        = number
  default     = 1
}
