# Zaiblify v0.1 architecture

## Product boundary

Zaiblify v0.1 is an offline Flutter Android app for transforming selected text into Unicode styles. AI features, accounts, cloud sync, history, and real font installation are intentionally excluded.

## Layers

- `lib/app.dart`: app bootstrap, startup gate, splash, first-run tour, shell navigation, and initial screens.
- `lib/theme/app_theme.dart`: Material 3 light/dark themes. `ThemeMode.system` is the default.
- `lib/features/formatting/`: future home for formatting actions, Unicode maps, and transformation tests.
- `lib/features/process_text/`: future Android integration layer for `ACTION_PROCESS_TEXT`.
- `assets/branding/`: app logo and brand assets.

## Theme rules

- Never hard-code white or black for surfaces, cards, borders, or text.
- Read colors from `Theme.of(context).colorScheme`.
- Use `ThemeMode.system` by default.
- Light and dark mode must both be tested.
- Prefer Material 3 semantic colors: `surface`, `surfaceContainerHighest`, `primaryContainer`, `onSurfaceVariant`, and `outlineVariant`.

## v0.1 screens

1. Quick splash screen.
2. Three-page first-run tour, persisted with `SharedPreferences`.
3. Home screen.
4. Styles gallery.
5. Settings screen.
6. Process-text transformation screen will be added after native Android integration is implemented.

## Navigation

The shell uses a floating, rounded navigation container with a translucent surface, subtle border, and shadow. It currently contains Home, Styles, and Settings.

## Dependencies

Keep dependencies minimal:

- Flutter SDK
- `shared_preferences` for first-run state

Do not add networking or AI SDKs in v0.1.