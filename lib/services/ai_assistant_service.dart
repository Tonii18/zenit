import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zenit/core/secure_storage.dart';
import 'package:zenit/models/recipe_request.dart';

class AiAssistantService {
  static const String url = 'http://192.168.137.1:8080';

  static Future<String?> recipeRequest(RecipeRequest recipeRequest) async {
    final token = await SecureStorage.getToken();

    String endpoint = '/recipe/request';

    try {
      final response = await http.post(
        Uri.parse(url + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(recipeRequest.toJson()),
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
}
