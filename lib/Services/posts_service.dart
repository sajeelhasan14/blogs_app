import 'dart:convert';
import 'package:blogs_app/Models/post_model.dart';
import 'package:blogs_app/Services/api_service.dart';
import 'package:http/http.dart' as http;

class PostsService {
  Future<PostModel> getPosts() async {
    final url = Uri.parse(ApiService.posts);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      return PostModel.fromJson(responseBody);
    } else {
      throw Exception("Ooops! Something went Wrong");
    }
  }
}
