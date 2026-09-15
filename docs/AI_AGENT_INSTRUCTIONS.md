# Instructions for OpenCode and other AI coding agents

## Project

Zaiblify is a Flutter Android app. The v0.1 goal is offline Unicode text styling. Do not introduce AI features yet.

## Before changing code

1. Read `README.md`, `docs/ARCHITECTURE.md`, and this file.
2. Inspect the current repository before creating files.
3. Preserve existing design language and theme behavior.
4. Make small, reviewable changes.
5. Run `flutter pub get`, `dart format`, `flutter analyze`, and tests when Flutter is available.

## Product priorities

1. Reliable text transformation.
2. Android text-selection integration through `ACTION_PROCESS_TEXT`.
3. Beautiful, accessible UI.
4. Light, dark, and system theme correctness.
5. Minimal dependencies and offline behavior.

## UI rules

- Use Material 3 and the existing theme tokens.
- Never hard-code black/white for UI surfaces or text.
- Use `ColorScheme` values so dark mode remains legible.
- Keep rounded cards and floating navigation subtle, not excessive.
- Support small screens and text scaling.
- Use semantic labels for icons and buttons.
- Do not add gradients everywhere; reserve them for hero moments.

## Branding

The final transparent logo filename is `assets/branding/zaiblify_logo.png`. Do not rename it without updating all references.

## Scope restrictions

Do not add login, analytics, remote APIs, AI, subscriptions, cloud sync, or a database in v0.1 unless explicitly requested.

## Coding style

- Prefer small widgets and clear names.
- Keep business logic out of UI widgets.
- Add unit tests for every new formatter.
- Preserve unsupported characters, whitespace, punctuation, emoji, and line breaks.
- Do not claim that Unicode styles are real installed fonts.
