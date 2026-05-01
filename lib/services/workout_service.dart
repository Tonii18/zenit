// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/models/exercise_model.dart';

class WorkoutService {
  static const String url = 'https://zenit-backend-rx9o.onrender.com';

  static Future<bool> createExercise(ExerciseModel exercise) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/workout/save'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(exercise.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<dynamic>?> getRoutine(String weekDay) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/workout/$weekDay'),
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

  static Future<bool> deleteExercise(int id) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.delete(
        Uri.parse(url + '/workout/delete/$id'),
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
}
