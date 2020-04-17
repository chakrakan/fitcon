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

## NOTE

Whenever you need to take the latest updates from `develop` branch to your own feature branch, do the following:
- `cd` to your working directory for the project
- `git checkout your_feature_branch`
- `git merge develop`
- if there are merge conflicts fix them locally
- `git add .` to add everything within your feature branch
- `git commit` to commit everything added
- `git push` to see those changes - at this point you should be even with changes from develop
