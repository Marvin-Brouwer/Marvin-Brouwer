resource "github_repository_dependabot_security_updates" "this" {
  repository = var.repository
  enabled    = true
}

# Read by the dependabot-auto-merge caller, which passes them on to the
# reusable workflow. Variables, unlike secrets, are visible to runs that
# dependabot triggers.
resource "github_actions_variable" "auto_approve_major" {
  repository    = var.repository
  variable_name = "DEPENDABOT_AUTO_APPROVE_MAJOR"
  value         = tostring(var.auto_approve_major)
}

resource "github_actions_variable" "auto_approve_actions_major" {
  repository    = var.repository
  variable_name = "DEPENDABOT_AUTO_APPROVE_ACTIONS_MAJOR"
  value         = tostring(var.auto_approve_actions_major)
}
