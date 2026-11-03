# Repository setup

Besides my profile README, this repo holds the shared setup for my other repositories: reusable workflows and OpenTofu modules. Nothing here runs on behalf of other repos. Each repo calls these pieces from its own workflows, with its own credentials.

| What | Where |
| --- | --- |
| Dependabot auto-approve and auto-merge | [`.github/workflows/dependabot-auto-merge.yml`](../.github/workflows/dependabot-auto-merge.yml) |
| Dependabot update queue | [`.github/workflows/dependabot-rebase.yml`](../.github/workflows/dependabot-rebase.yml) |
| OpenTofu plan and apply | [`.github/workflows/tofu.yml`](../.github/workflows/tofu.yml) |
| Repo settings, ruleset, Dependabot settings | [`tofu/`](../tofu) |

Guides:

- [Setting up a repo](repos/setup.md), for a new repo or the one-time App setup.
- [Migrating an existing repo](repos/migration.md), for a repo that was set up by hand.
- [Contribution guide](contributing.md), the default for every repo that doesn't have its own.

## Versioning

Repos pin `@v1` for workflows and `?ref=v1` for modules. `v1` is a moving tag: move it to a new commit on `main` to roll a change out everywhere. A breaking change gets `v2`.

Module bumps never get auto-approved by Dependabot, because merging one runs `tofu apply`. Read the plan on that PR before approving.
