import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // JWT token managment

  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_key';
  static const _emailKey = 'email_key';

  // Step managment

  static const _stepKey = 'step_offset';
  static const _stepDateKey = 'step_offset_date';

  static Future<void> saveStepOffset(int offset, String date) async {
    await _storage.write(key: _stepKey, value: offset.toString());
    await _storage.write(key: _stepDateKey, value: date);
  }

  static Future<int?> getStepOffset() async {
    final value = await _storage.read(key: _stepKey);
    return value != null ? int.parse(value) : null;
  }

  static Future<String?> getStepOffsetDate() async {
    return await _storage.read(key: _stepDateKey);
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken(String token) async {
    await _storage.delete(key: _tokenKey);
  }

  // Email management

  static Future<void> saveEmail(String email) async {
    await _storage.write(key: _emailKey, value: email);
  }

  static Future<String?> getEmail() async {
    return await _storage.read(key: _emailKey);
  }

  static Future<void> deleteEmail() async {
    await _storage.delete(key: _emailKey);
  }
}
