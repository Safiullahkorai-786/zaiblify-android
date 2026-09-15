# Android Release Checklist

- Set final application ID in `android/app/build.gradle`.
- Set app label to `Zaiblify`.
- Configure launcher and adaptive icons using the approved Zaiblify logo.
- Configure release signing; never commit keystores or passwords.
- Verify Android 13+ notification and photo permissions are not requested unnecessarily.
- Add privacy-policy URL to the Play Console listing.
- Run `flutter pub get`.
- Run `flutter analyze`.
- Run `flutter test`.
- Run `flutter build apk --debug`.
- Run `flutter build appbundle --release`.
- Test on a physical Android device before publishing.
