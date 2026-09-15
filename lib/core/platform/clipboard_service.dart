import 'package:flutter/services.dart';

/// Small platform boundary for clipboard operations.
/// Keeping this separate makes the editor easy to test and extend later.
class ZaiblifyClipboard {
  const ZaiblifyClipboard._();

  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text ?? '';
  }
}
