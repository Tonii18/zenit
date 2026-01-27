// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/models/user_register.dart';

class Auth {
  // Local URL

  static const String url = 'http://192.168.1.134:8080';
  static const String urlHp = 'http://10.10.6.143:8080';

  // Register user

  static Future<String?> register(UserRegister user) async {
    try {
      String endpoint = '/auth/register';

      final response = await http.post(
        Uri.parse(urlHp + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        final body = response.body;
        return body.isNotEmpty ? body : 'Unknown error';
      }
    } catch (e) {
      return '$e: Cannot connect to the server';
    }
  }

  // Log in user

  static Future<String?> login(String email, String password) async {
    String endpoint = '/auth/login';

    try {
      final response = await http.post(
        Uri.parse(urlHp + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        return token;
      } else if (response.statusCode == 401) {
        return 'Email or password incorrect';
      } else {
        return response.body.isNotEmpty ? response.body : 'Unknown error';
      }
    } catch (e) {
      return '$e: Cannot connect to the server';
    }
  }
}
