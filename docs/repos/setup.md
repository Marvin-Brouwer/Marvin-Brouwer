# Setting up a repo

Everything a repo needs, in order. The App section is a one-time job. The rest is per repo. Starting from the template repo saves most of the file copying.

## Once: the automation App

Everything automated (approving, merging, updating Dependabot PRs, OpenTofu) runs as a private GitHub App, so it shows up as `<app>[bot]` and not as you. Its key doesn't expire.

1. Go to **Settings → Developer settings → GitHub Apps → New GitHub App**.
2. Give it a name, set any homepage URL, and turn the webhook off.
3. Repository permissions, all **Read and write**: Administration, Contents, Pages, Pull requests, Variables, Workflows.
4. "Only on this account", then create it.
5. Note the **App ID** and generate a **private key** (a `.pem` download). Keep the key somewhere safe. You paste it into every repo.

## Per repo

### 1. Install the App

In the App's settings, open **Install App** and add the repo, or choose "All repositories" once.

### 2. Credentials

In the repo's **Settings → Secrets and variables**:

| Kind | Where | Name | Value |
| --- | --- | --- | --- |
| Variable | Actions | `AUTOMATION_APP_ID` | the App ID |
| Secret | Actions | `AUTOMATION_APP_PRIVATE_KEY` | contents of the `.pem` |
| Secret | Dependabot | `AUTOMATION_APP_PRIVATE_KEY` | the same key again |

The key has to be in both places. Runs that Dependabot triggers can only read Dependabot secrets, and everything else can only read Actions secrets. Missing the Dependabot one doesn't fail loudly: the auto-merge job just can't approve.

### 3. Workflows

Three thin callers in `.github/workflows/`. They're identical in every repo.

`dependabot-auto-merge.yml`:

```yaml
name: Dependabot auto-merge

on: pull_request

jobs:
  dependabot:
    uses: Marvin-Brouwer/Marvin-Brouwer/.github/workflows/dependabot-auto-merge.yml@v1
    with:
      app-id: ${{ vars.AUTOMATION_APP_ID }}
      auto-approve-major: ${{ vars.DEPENDABOT_AUTO_APPROVE_MAJOR == 'true' }}
      auto-approve-actions-major: ${{ vars.DEPENDABOT_AUTO_APPROVE_ACTIONS_MAJOR != 'false' }}
    secrets: inherit
```

`dependabot-rebase.yml`:

```yaml
name: Dependabot rebase

on:
  push:
    branches: ["main"]
  # Picks the line back up after a PR fails or is closed, which doesn't push.
  schedule:
    - cron: "0 * * * *"
  workflow_dispatch:

jobs:
  dependabot:
    uses: Marvin-Brouwer/Marvin-Brouwer/.github/workflows/dependabot-rebase.yml@v1
    with:
      app-id: ${{ vars.AUTOMATION_APP_ID }}
    secrets: inherit
```

`tofu.yml`. Don't add a path filter to the trigger. The workflow skips its own jobs when `infra/` didn't change, and a filtered trigger would leave a required check waiting forever.

```yaml
name: OpenTofu

on:
  pull_request:
  push:
    branches: ["main"]

jobs:
  tofu:
    uses: Marvin-Brouwer/Marvin-Brouwer/.github/workflows/tofu.yml@v1
    with:
      app-id: ${{ vars.AUTOMATION_APP_ID }}
    secrets: inherit
```

### 4. `dependabot.yml`

This one stays per repo, because Dependabot only reads it from the repo itself. Add the `terraform` ecosystem next to whatever the repo already uses, so module bumps come in as PRs. It reads `.tf` files whether you run them with Terraform or OpenTofu.

```yaml
version: 2
updates:
  - package-ecosystem: github-actions
    directory: /
    schedule:
      interval: weekly
  - package-ecosystem: terraform
    directory: /infra
    schedule:
      interval: weekly
```

### 5. `infra/main.tf`

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }
}

# Owner and token come from GITHUB_OWNER and GITHUB_TOKEN, which tofu.yml sets.
provider "github" {}

module "repository" {
  source = "git::https://github.com/Marvin-Brouwer/Marvin-Brouwer.git//tofu/repository?ref=v1"
  name   = "my-repo"
  # pages = false  # for a repo without a site
}

module "branch_rules" {
  source     = "git::https://github.com/Marvin-Brouwer/Marvin-Brouwer.git//tofu/branch-rules?ref=v1"
  repository = module.repository.name
  app_id     = 123456 # the App ID

  # Names as GitHub shows them on a PR. A reusable workflow's jobs show as
  # "<caller job> / <job name>".
  required_checks = [
    "tofu / OpenTofu plan",
  ]
}

module "dependabot" {
  source     = "git::https://github.com/Marvin-Brouwer/Marvin-Brouwer.git//tofu/dependabot?ref=v1"
  repository = module.repository.name
  # auto_approve_major = true  # approve every major, not just github-actions ones
}

# The repo already exists, so adopt it instead of creating it.
import {
  to = module.repository.github_repository.this
  id = "my-repo"
}
```

What each module sets, and every input, is in its `variables.tf` under [`tofu/`](../../tofu).

### 6. First apply

Open a PR with all of the above. The "OpenTofu plan" job shows the plan in its summary. Read it, since it shows every setting that is about to change. Merge it, and apply runs on `main` and commits `infra/terraform.tfstate`.

Run `tofu init` locally once and commit `infra/.terraform.lock.hcl`, so the provider version is pinned. The plan job creates it otherwise, but doesn't commit it.

## Day to day

- **Patch and minor bumps** get approved and merged by the App once checks pass.
- **Major bumps** are approved for github-actions, and wait for you everywhere else, unless `auto_approve_major` is on. Auto-merge is already queued, so your approval is the only click.
- **Module bumps** always wait for you. Read the plan first.
- **A Dependabot PR that the queue updated and then failed** is no longer maintained by Dependabot. Comment `@dependabot recreate` on it to hand it back.
