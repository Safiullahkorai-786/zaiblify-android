# Zaiblify Production Readiness

## Implemented foundations

- Real clipboard copy and paste through `ZaiblifyClipboard`.
- Share service through `ZaiblifyShare`.
- Explicit advertising consent storage and consent screen foundation.
- Offline-first architecture with no AI dependency.
- Theme support for system, light, and dark modes.
- First-run onboarding and branded splash screen.
- Formatter and editor test foundations.

## Release gates

Before publishing, run from a real Flutter/Android environment:

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
flutter build apk --release
flutter build appbundle --release
```

Also verify:

- Android application ID and version code.
- App label is `Zaiblify`.
- Launcher and adaptive icons are generated from the approved logo.
- Privacy policy URL is published and reachable.
- Consent is collected before initializing any advertising SDK.
- No advertising SDK is initialized when consent is denied or not yet collected.
- Share, clipboard, back navigation, rotation, dark mode, and accessibility work on a physical Android device.
- Release signing is configured outside source control.

## Monetization rule

Advertising remains disabled until the monetization phase. When enabled, initialize the advertising SDK only after consent state has been loaded and the user has made an eligible choice.
