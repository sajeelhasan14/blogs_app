import 'dart:convert';

import 'package:blogs_app/Models/tags_stories_model.dart';
import 'package:blogs_app/Services/api_service.dart';
import 'package:http/http.dart' as http;

class TagsStoriesService {
  Future<TagsStoriesModel> getTagsData(String tag) async {
    final String url = tag == "all"
        ? ApiService.posts
        : ApiService.postsByTag(tag);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return TagsStoriesModel.fromJson(responseBody);
    } else {
      throw Exception("Ooops! Something went Wrong");
    }
  }
}
