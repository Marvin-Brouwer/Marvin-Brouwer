variable "name" {
  description = "Name of the repository. It has to exist already: import it, this module never creates one."
  type        = string
}

variable "has_issues" {
  description = "Enable issues."
  type        = bool
  default     = true
}

variable "has_wiki" {
  description = "Enable the wiki."
  type        = bool
  default     = false
}

variable "has_discussions" {
  description = "Enable discussions."
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Enable projects."
  type        = bool
  default     = false
}

variable "squash_merge_commit_message" {
  description = "Body of a squash commit: PR_BODY, COMMIT_MESSAGES or BLANK."
  type        = string
  default     = "PR_BODY"
}

variable "pages" {
  description = "Enable GitHub Pages, built by a workflow."
  type        = bool
  default     = true
}

variable "pages_cname" {
  description = "Custom domain for Pages. Null for the default github.io address."
  type        = string
  default     = null
}

variable "default_branch" {
  description = "The default branch."
  type        = string
  default     = "main"
}
