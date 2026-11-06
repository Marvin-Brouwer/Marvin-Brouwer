# Migrating an existing repo

For a repo that was set up by hand. Follow [setup](setup.md) for the files and credentials. This page covers what's already there and gets in the way.

## Before the first PR

1. **Remove classic branch protection.** Go to **Settings → Branches** and delete the rule on `main`. It keeps applying next to the new ruleset, and where they differ the stricter one wins, which makes the ruleset hard to reason about. Rulesets you made by hand under **Settings → Rules** go too: the module creates its own.
2. **Delete the old local workflows** that the callers replace, typically `dependabot-auto-merge.yml` and `dependabot-rebase.yml`. Keep their file names for the callers if you like, since only the content changes.
3. **Delete the old secret**, `DEPENDABOT_APPROVE_TOKEN` or similar, from both Actions and Dependabot secrets, once the App's key is in place.

## The first PR

Add the callers, `infra/main.tf` with its `import` block, and the `terraform` entry in `dependabot.yml`, all in one PR.

The plan on that PR is the one to read carefully. It shows every difference between what you clicked in before and the shared defaults. Things to look for:

- **Settings flipping that you rely on**, for example Pages being turned on for a repo without a site (`pages = false`), or issues being turned off.
- **`required_checks` names.** They have to match exactly what GitHub shows on a PR, or every PR waits on a check that never reports. Copy them from the checks list of a recent PR.
- **Anything being destroyed.** The repository resource refuses to be destroyed, but a plan that tries means the `import` didn't match.

Merging runs the first apply. You can leave the `import` block in, since it does nothing once the repo is in the state.

## After merging

Check that it works on a real Dependabot PR:

- A patch or minor bump gets approved by the App and merges on its own.
- With `auto_approve_major` off, a non-actions major bump gets auto-merge queued but no approval.
- When several Dependabot PRs are open, the update queue brings the oldest one up to date after each merge.

If a Dependabot PR that the queue updated fails, comment `@dependabot recreate`. Check that Dependabot takes it back and rebuilds it. That's the one part of this setup that's untested.
