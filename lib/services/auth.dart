// ignore_for_file: unrelated_type_equality_checks, avoid_print, body_might_complete_normally_nullable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zenit/models/user_profile.dart';
import 'package:zenit/models/user_register.dart';

class Auth {
  // Local URL

  static const String url = 'http://192.168.1.133:8080';
  static const String urlHp = 'http://10.10.6.143:8080';
  static const String urlHp2 = 'http://172.20.10.4:8080';

  // Register user

  static Future<String?> register(UserRegister user) async {
    try {
      String endpoint = '/auth/register';

      final response = await http.post(
        Uri.parse(urlHp2 + endpoint),
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
        Uri.parse(urlHp2 + endpoint),
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

  // Verify user email

  static Future<bool> sendVerificationEmail(String userEmail) async {
    String endpoint = '/auth/send/verification';

    try {
      final response = await http.post(
        Uri.parse(urlHp2 + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': userEmail}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Check whether an user is verified or not

  static Future<bool> isVerified(String email) async {
    String endpoint = '/auth/is/verified?email=$email';

    try {
      final response = await http.get(Uri.parse(urlHp2 + endpoint));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['verified'] == true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Register user personal data on 'users_profiles' table

  static Future<String?> dataCompilation(UserProfile userProfile) async {
    String endpoint = '/data/compilation';

    try {
      final response = await http.post(
        Uri.parse(urlHp2 + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: {json.encode(userProfile.toJson())},
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        final body = response.body;
        return body;
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
