# Editor Integration

The editor uses `lib/core/platform/clipboard_service.dart` as its platform boundary.

## Available operations

- `ZaiblifyClipboard.copy(text)` writes plain text to the system clipboard.
- `ZaiblifyClipboard.paste()` reads plain text from the system clipboard.

The UI should surface copy/paste failures through a `SnackBar` without exposing platform exceptions to users. Clipboard access is local and does not require network permission.

## Next editor tasks

1. Inject or wrap the clipboard boundary in widget tests.
2. Add copy, paste, clear, and share actions to `EditorScreen`.
3. Disable copy when the generated output is empty.
4. Preserve the input when changing styles.
5. Add accessibility labels for icon-only actions.
