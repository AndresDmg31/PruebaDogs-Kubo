
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _kApiKey = "api_key";

  static Future<void> setApiKey(String value) async {
    await _storage.write(key: _kApiKey, value: value);
  }

  static Future<String?> getApiKey() async {
    return await _storage.read(key: _kApiKey);
  }

  static Future<void> deleteApiKey() async {
    await _storage.delete(key: _kApiKey);
  }
}