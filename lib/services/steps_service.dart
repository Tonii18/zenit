// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';

class StepsService {
  static const String url = 'http://192.168.137.1:8080';

  // Get today's steps

  static Future<Map<String, dynamic>?> getTodaySteps() async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/steps/today'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Save and update steps

  static Future<bool> saveSteps({
    required int steps,
    required double distanceKm,
    required double caloriesBurned,
  }) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/steps/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'date': DateTime.now().toIso8601String().split('T')[0],
          'steps': steps,
          'distanceKm': distanceKm,
          'caloriesBurned': caloriesBurned,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Get week's data

  static Future<Map<String, dynamic>?> getWeekStats() async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/steps/week'),
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
