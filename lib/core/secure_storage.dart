import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  // JWT token managment

  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_key';
  static const _emailKey = 'email_key';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken(String token) async{
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