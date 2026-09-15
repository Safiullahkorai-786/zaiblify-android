# Zaiblify Android

A beautiful Flutter app for transforming ordinary text into expressive Unicode styles.

> v0.1 is intentionally offline and does not include AI features.

## Current foundation

- Flutter + Material 3
- System theme by default
- Light and dark theme support
- Quick splash screen
- First-run three-page tour
- Floating rounded navigation bar
- Home screen
- Styles gallery
- Settings screen
- Branding asset folder
- Architecture and AI-agent instructions

## Logo

Upload the transparent logo to:

`assets/branding/zaiblify_logo.png`

Then uncomment the asset declaration in `pubspec.yaml`.

## Run locally

```bash
flutter pub get
flutter run
```

## Planned next step

Implement the Unicode formatting engine and Android `ACTION_PROCESS_TEXT` integration. This will allow users to select text in supported apps, open Zaiblify, choose a style, and return the transformed text.

See:

- `docs/ARCHITECTURE.md`
- `docs/AI_AGENT_INSTRUCTIONS.md`
