# Settings every repo shares. Description, homepage, topics and visibility are
# left to the repo itself (ignore_changes), so this never overwrites them.
resource "github_repository" "this" {
  name = var.name

  has_issues      = var.has_issues
  has_wiki        = var.has_wiki
  has_discussions = var.has_discussions
  has_projects    = var.has_projects

  # Squash only, titled after the PR.
  allow_squash_merge          = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = var.squash_merge_commit_message

  allow_auto_merge       = true
  allow_update_branch    = true
  delete_branch_on_merge = true

  vulnerability_alerts = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  dynamic "pages" {
    for_each = var.pages ? [true] : []
    content {
      build_type = "workflow"
      cname      = var.pages_cname
    }
  }

  # Destroying this resource deletes the repository. Archive instead if it
  # ever comes to that, and refuse a plan that tries.
  archive_on_destroy = true

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      description,
      homepage_url,
      topics,
      visibility,
    ]
  }
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = var.default_branch
}

# Workflows get a read-only GITHUB_TOKEN unless they ask for more, and it can
# never approve a PR.
resource "github_workflow_repository_permissions" "this" {
  repository                       = github_repository.this.name
  default_workflow_permissions     = "read"
  can_approve_pull_request_reviews = false
}
