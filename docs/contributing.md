# Contribution guide

Thanks for taking the time. This is the default guide for my repositories. A repo with its own `CONTRIBUTING.md` overrides it, so check the repo first.

## Issues

Issues are the place for bug reports, feature requests and questions.

- **Search first.** Someone may have reported it already.
- **Bug reports:** say what you did, what you expected, and what happened instead. Check it still happens on the latest `main`. A minimal reproduction is worth more than a long description.
- **Feature requests:** explain the problem you're trying to solve, not only the solution you have in mind. Not everything fits the project's scope, and that's fine.
- **Security issues:** don't open a public issue. See the repo's security policy.

Keep discussions on topic and be decent to each other.

## Before you write code

**Ask first** for anything bigger than a small fix. Open an issue or comment on an existing one. A PR for a change nobody asked for may not get merged, however good it is.

## Pull requests

1. Branch off `main`, or fork the repo if you can't push to it.
2. Keep the PR to one change. Unrelated fixes go in their own PR.
3. Follow the repo's existing style, and make sure its checks pass locally where you can.
4. Fill in the PR template.

PRs are **squash merged**: the PR title becomes the commit subject on `main`, and the description becomes its body. Write both with that in mind. Your branch history doesn't need to be tidy, so there's no need to rebase or force push for its sake.

`main` needs one approving review and green checks before anything merges. Branches have to be up to date with `main`. Use the "Update branch" button when GitHub asks.

Not ready yet? Open it as a draft. Ready and green? Turn on auto-merge, and it lands once it's approved.

## Licence

By contributing, you agree that your contribution is licensed under the repo's licence.
