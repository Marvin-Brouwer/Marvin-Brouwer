[//]: # (Links)

[github-contribution-guide]: https://github.com/roots/guidelines/blob/master/CONTRIBUTING.md
[github-flow]: http://scottchacon.com/2011/08/31/github-flow.html

[//]: # (Header)

# Contribution guide

_This guide is based on [GitHub's example contribution guide][github-contribution-guide]
and [Scott Chacon's GitHub flow article][github-flow]._

This is the default guide for my repositories. A repository with its own `CONTRIBUTING.md` overrides it, so check there first.

<br/>

[//]: # (Body)

Please take a moment to review this document in order to make the contribution process easy and effective for everyone involved.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project.
In return, they should reciprocate that respect in addressing your issue or assessing patches and features.

## Using the issue tracker

The issue tracker is the preferred channel for [bug reports](#bug-reports), [feature requests](#feature-requests) and [submitting pull requests](#open-a-pull-request-at-any-time), but please respect the following restrictions:

* Please **do not** derail or troll issues.
* Keep the discussion on topic and respect the opinions of others.
* Please **do not** report security issues in public. Follow the repository's security policy instead.

## Bug reports

A bug is a _demonstrable problem_ that is caused by the code in the repository.
Good bug reports are extremely helpful, thank you!

Guidelines for bug reports:

1. **Use the GitHub issue search**
   Check if the issue has already been reported.
2. **Check if the issue has been fixed**
   Try to reproduce it using the latest `main` branch in the repository.
3. **Isolate the problem**
   Make sure that the code in the repository is _definitely_ responsible for the issue.

A good bug report shouldn't leave others needing to chase you up for more information.
Please try to be as detailed as possible in your report.

## Feature requests

Feature requests are welcome. But take a moment to find out whether your idea fits with the scope and aims of the project.
It's up to *you* to make a strong case to convince the developers of the merits of this feature.
Please provide as much detail and context as possible.

**Please ask first** before embarking on any significant code change (e.g. implementing features, refactoring code), otherwise you risk spending a lot of time working on something that the developers might not want to merge into the project.

## GitHub flow

### Anything in the `main` branch is deployable

Make sure your code is deploy ready.
`main` is protected: a change only lands through a pull request with green checks and an approving review.

### Create descriptive branches off of `main`

<details>
   <summary>(Optional) Fork</summary>
   <br/>

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the repo, clone your fork, and configure the remotes:

```bash
# Clone your fork of the repo into the current directory
git clone https://github.com/<your-username>/<repo-name>
# Navigate to the newly cloned directory
cd <repo-name>
# Assign the original repo to a remote called "upstream"
git remote add upstream https://github.com/<upstream-owner>/<repo-name>
```

**If you cloned a while ago,** get the latest changes from upstream:

```bash
git checkout main
git pull upstream main
```

</details>

Create a new topic branch (off the `main` branch) to contain your feature, change, or fix:

```bash
git checkout -b <issue-number>-<friendly-description>
```

_It's probably easiest to use the title of the issue as the `<friendly-description>`._
_**Or**, if you're not working from a fork, use "Create a branch" in the issue's sidebar._

### Push to named branches constantly

Commit your changes in logical chunks and make your change's intent clear in the message.
Push often, so other contributors can see your progress.

Pull requests are squash merged, so your branch history doesn't have to be tidy.
There's no need to rebase or force push for its sake: merge `main` into your branch, or use the "Update branch" button on the pull request.

### Open a pull request at any time

Good pull requests (patches, improvements, new features) are a fantastic help.
They should remain focused in scope and avoid containing unrelated commits.

Your changes do not have to be ready to open a pull request.
If you don't intend it to be merged yet, open it as a draft.

[Open a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) with a clear title and description, and fill in the pull request template.
The target branch should be `main` unless a maintainer tells you otherwise.

**Mind the title and description.** The pull request is squash merged: its title becomes the commit message on `main` and its description becomes the commit body.
Reference the issue it resolves.

#### Final pull request

When finalizing your change, please make sure:

* It's marked ready for review, not a draft.
* All checks are green and the branch is up to date with `main`.
* Every item of the template's checklist is checked. Don't remove items, but feel free to add any that apply.
* Auto-merge is on, so it lands as soon as it's approved.

## License

By contributing your code, you agree to license your contribution under the license of the repository.
