import 'package:share_plus/share_plus.dart';

/// Platform boundary for sharing formatted text.
class ZaiblifyShare {
  const ZaiblifyShare._();

  static Future<void> shareText(String text) async {
    if (text.trim().isEmpty) return;
    await Share.share(text, subject: 'Created with Zaiblify');
  }
}
