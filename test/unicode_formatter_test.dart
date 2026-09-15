import 'package:flutter_test/flutter_test.dart';
import 'package:zaiblify/core/formatting/unicode_formatter.dart';

void main() {
  group('UnicodeFormatter', () {
    test('formats ASCII letters as bold', () {
      expect(
        UnicodeFormatter.apply('Hello', ZaibStyle.bold),
        '𝐇𝐞𝐥𝐥𝐨',
      );
    });

    test('preserves unsupported characters', () {
      expect(
        UnicodeFormatter.apply('Hello 123!', ZaibStyle.bold),
        '𝐇𝐞𝐥𝐥𝐨 𝟏𝟐𝟑!',
      );
    });

    test('returns empty input unchanged', () {
      expect(UnicodeFormatter.apply('', ZaibStyle.script), '');
    });
  });
}
