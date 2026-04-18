// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';

class JournalService {
  static const String url = 'http://192.168.137.1:8080';

  static Future<bool> createEntry(String title, String content) async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.post(
        Uri.parse(url + '/journal/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'title': title, 'content': content}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<dynamic>?> getEntries() async {
    final token = await SecureStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(url + '/journal/entries'),
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
