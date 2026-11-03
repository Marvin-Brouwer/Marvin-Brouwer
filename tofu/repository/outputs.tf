output "name" {
  description = "Name of the repository, to pass on to the other modules."
  value       = github_repository.this.name
}

output "default_branch" {
  description = "The default branch."
  value       = github_branch_default.this.branch
}
