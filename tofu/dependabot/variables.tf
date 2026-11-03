variable "repository" {
  description = "Name of the repository."
  type        = string
}

variable "auto_approve_major" {
  description = "Auto-approve semver-major bumps outside github-actions. Off means they wait for your approval, with auto-merge already queued."
  type        = bool
  default     = false
}

variable "auto_approve_actions_major" {
  description = "Auto-approve semver-major bumps of github-actions."
  type        = bool
  default     = true
}
