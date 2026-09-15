# Zaiblify implementation phases

Zaiblify is the product; **Zaib Labs** is the company.

## Phase 1 — Foundation and visual system
- Flutter project structure
- Fast splash and first-run tour
- iOS-inspired visual language implemented with Android Material 3
- Floating glass-style bottom navigation
- System, light, and dark theme persistence
- Real branding asset at `assets/branding/zaiblify_logo.png`

## Phase 2 — Formatting engine and editor
- Offline Unicode formatter
- Bold, italic, bold italic, monospace
- Script, double-struck, fraktur, small caps, fullwidth, bubble
- Reverse, upside-down, underline, and strikethrough
- Live editor and preview gallery
- Preserve unsupported characters instead of deleting them

## Phase 3 — Android integration
- Generate/verify Android host project with `flutter create .`
- Add Android `ACTION_PROCESS_TEXT` receiver
- Receive selected text and return transformed text to the calling app
- Add clipboard and share actions
- Add automated formatter tests and device testing

## Phase 4 — Monetization and privacy
- Integrate Google Mobile Ads only after the core flow is stable
- Use test ad IDs during development
- Add limited interstitial ads with cooldowns and frequency caps
- Never show ads during splash, onboarding, or immediately after every tap
- Add consent flow where required, privacy policy, app-ads.txt, and Data Safety disclosure

## Phase 5 — Play Store release
- Final application ID and adaptive launcher icon
- Release signing and secure keystore handling
- Versioning, app bundle build, and Play Integrity configuration if needed
- Screenshots, feature graphic, store listing, content rating
- Closed testing, crash verification, performance review, and production rollout

## Current status
Phase 1 is implemented. Phase 2 has its first working formatter and editor foundation. Phases 3–5 require a Flutter/Android build environment, device testing, production ad configuration, and Play Console setup before the app can honestly be called Play Store-ready.
