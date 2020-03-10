## Instructions and Branching Strategy

1. We will primarily be working on the `develop` branch and will seldom commit directly to the `master` branch
2. The source-code at HEAD on `master` branch is meant to represent a production ready state
3. We use `develop` as the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release/iteration
4. When the source code in the develop branch reaches a stable point and is ready to be released, all of the changes should be merged back into `master` and then tagged with a release number.

### Main Types of branches

#### Feature

May branch off from: `develop`.

Must merge back into: `develop`.

Branch naming convention: anything except `master`, `develop`.

I prefer feat/YOURNAME for clarity of who is working on it, but it does not have to be that and can also just be the actual feature name.

When starting work on a new feature, branch off from the develop branch.

`git checkout -b feat/xyz develop`

Finished features may be merged into the develop branch to add them to the upcoming release:

```zsh
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```

#### BugFix

May branch off from: `develop`, your own particular `feat/xyz` branch.

Must merge back into: `develop`, your own particular `feat/xyz` branch. 

Branch naming convention: anything except `master`, `develop`, `feature/feat etc.`.  

I prefer bugfix/YOURNAME for clarity of who is working on it, but it does not have to be that.

Similar intruction as above except you might be checking out your feature branch and merging back to it instead of `develop` if the new feature is what introduced the bug.

#### Lastly, NOTE:

Delete a local branch using `git branch -d branch-name`. 

You can delete a remote branch using `git push remote-name --delete branch-name` or using Github's UI.

## Review

At the end of every 2 weeks/iteration, we will have a meeting to review all work and push all changes from `develop` to the `master` branch.

In order to prevent confusion, the default branch for the repository has been set to `develop` so we will be working on that.

I've also set up a branch rule for the `master` branch which will only allow pull-requests to go through once reviewed by at least 3 members of the team (I expect everyone to be present for the code-reviews).
