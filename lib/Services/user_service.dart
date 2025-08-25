import 'dart:convert';

import 'package:blogs_app/Models/user_model.dart';
import 'package:blogs_app/Services/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel> getUsers() async {
    final url = Uri.parse(ApiService.user);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return UserModel.fromJson(responseBody);
    } else {
      throw Exception("Ooops! Something went Wrong");
    }
  }
}
