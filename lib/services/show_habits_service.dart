// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';

class ShowHabitsService {
  static const String url = 'https://zenit-backend-rx9o.onrender.com';

  static Future<bool> createHabit(String habit) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/habit/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'name': habit}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

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

  static Future<bool> deleteHabit(int id) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.delete(
        Uri.parse(url + '/habit/delete/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        print(response.statusCode);
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> checkHabit(int id) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/habit/check/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
