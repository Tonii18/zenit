// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';

class ShowHabitsService {
  static const String url = 'https://zenit-backend-rx9o.onrender.com';

  static Future<List<dynamic>?> getHabits() async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/habit/show'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
