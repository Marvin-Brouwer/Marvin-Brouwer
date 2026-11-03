locals {
  # Built-in repository role id for "Admin".
  admin_role_id = 5
}

resource "github_repository_ruleset" "branch" {
  name        = var.branch
  repository  = var.repository
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/${var.branch}"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = var.app_id
    actor_type  = "Integration"
    bypass_mode = "always"
  }

  bypass_actors {
    actor_id    = local.admin_role_id
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = var.required_approvals
      dismiss_stale_reviews_on_push     = true
      required_review_thread_resolution = true
    }

    dynamic "required_status_checks" {
      for_each = length(var.required_checks) > 0 ? [true] : []
      content {
        # Branches have to be up to date with the base before merging.
        strict_required_status_checks_policy = true

        dynamic "required_check" {
          for_each = var.required_checks
          content {
            context = required_check.value
          }
        }
      }
    }
  }
}
