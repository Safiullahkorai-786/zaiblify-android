import 'package:shared_preferences/shared_preferences.dart';

class ConsentStore {
  const ConsentStore._();

  static const _advertisingConsentKey = 'advertising_consent';

  static Future<bool> hasAdvertisingConsent() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_advertisingConsentKey) ?? false;
  }

  static Future<void> setAdvertisingConsent(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_advertisingConsentKey, value);
  }
}
