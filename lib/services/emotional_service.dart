// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';

class EmotionalService {
  static const url = 'https://zenit-backend-rx9o.onrender.com';

  static Future<bool> saveRecord(int value) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/emotional/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'emotionalValue': value}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<dynamic>?> getMonthRecords() async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/emotional/show'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

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
