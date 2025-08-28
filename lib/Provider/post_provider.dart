import 'package:blogs_app/Models/post_model.dart';

import 'package:blogs_app/Services/posts_service.dart';
import 'package:flutter/widgets.dart';

class PostProvider extends ChangeNotifier {
  final PostsService _postsService = PostsService();

  List<Posts> _posts = List.empty(growable: true);
  List<Posts> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPosts() async {
    if (_posts.isNotEmpty) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _postsService.getPosts();
      _posts = response.posts ?? [];
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void deletePost(int index) {
    _posts.removeAt(index);
    notifyListeners();
  }
}
