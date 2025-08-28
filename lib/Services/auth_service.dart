import 'dart:convert';

import 'package:blogs_app/Models/user_model.dart';
import 'package:blogs_app/Models/user_post_model.dart';
import 'package:blogs_app/Services/api_service.dart';
import 'package:blogs_app/Storage/session_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Users?> login(String username, String password) async {
    final url = Uri.parse(ApiService.login);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data["accessToken"];
      await SessionStorage().saveToken(accessToken);
      return Users.fromJson(data);
    }
    return null;
  }

  Future<Users?> getProfile() async {
    final token = await SessionStorage().getToken(); // ✅ fixed await
    if (token == null) return null;

    final url = Uri.parse(ApiService.me);
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<void> logout() async {
    await SessionStorage().deleteToken();
  }

  Future<UserPostModel> getUserPosts(int userId, String token) async {
    final url = Uri.parse("${ApiService.user}/$userId/posts");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserPostModel.fromJson(data); // whole object parsed once
    } else {
      throw Exception("Failed to load user posts");
    }
  }

  Future<String?> getToken() async {
    return await SessionStorage().getToken();
  }

  // Optional: If you want a method to get the token immediately after login
  Future<String?> getProfileToken() async {
    final token = await SessionStorage().getToken();
    return token;
  }
}
