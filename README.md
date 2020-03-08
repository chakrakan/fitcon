# Fitcon

Flutter/Dart Project for COMP231, Centennial College

## Prerequisites 
please ensure you have the following software installed on your computer:
1. Flutter SDK (comes with Dart SDK)
 - You can open your Command Line/Terminal and type:   flutter --version    to see which version you have (latest advised).
2. An IDE to work with the Dart/Flutter project - preferably Android Studio or VSCode
3. You should also have the necessary setup for emulators so you can run the application locally on your computer
4. After all of the steps above done, you can use this command to check if you have everything in working order:

            flutter doctor -v 
         
## How to run this project for the first time
1. Open this project in Android Studio/VSCode
2. Open your emulator of choice whether Android/iOS
3. Run `flutter doctor -v` so see if all prerequisites are checked for you, if not fix those
4. Use `flutter pub get` to download all the dependencies listed in the `pubspec.yml` file
5. Finally, use `flutter run` to run the app on your open emulator


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

## Review

At the end of every 2 weeks/iteration, we will have a meeting to review all work and push all changes from `develop` to the `master` branch.
