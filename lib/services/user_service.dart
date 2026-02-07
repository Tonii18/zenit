// ignore_for_file: empty_catches, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/models/user_profile.dart';

class UserService {
  static const String url = 'http://192.168.1.134:8080';

  static Future<String> getUserName() async {
    final token = await SecureStorage.getToken();
    String endpoint = '/user/name';

    try {
      final response = await http.get(
        Uri.parse(url + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }
      );

      if(response.statusCode == 200){
        String name = response.body;
        return name;
      }else{
        print(response.statusCode);
        throw Exception(response.body);
      }
    } catch (e) {
      print('Failed to load user: $e');
      rethrow;
    }
  }

  static Future<UserProfile> getCurrentUser() async {
    final token = await SecureStorage.getToken();
    String endpoint = '/user/account/profile';

    if(token == null){
      throw Exception('Token not found');
    }

    print(token);

    try {
      final response = await http.get(
        Uri.parse(url + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if(response.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return UserProfile.fromJson(jsonData);
      }else{
        print(response.statusCode);
        throw Exception(response.body);
      }
    } catch (e) {
      print('Failed to load user: $e');
      rethrow;
    }
  }
}