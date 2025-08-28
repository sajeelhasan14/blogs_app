import 'package:blogs_app/Models/user_post_model.dart';
import 'package:blogs_app/Services/auth_service.dart';
import 'package:blogs_app/Storage/session_storage.dart';
import 'package:flutter/material.dart';

class UserPostsProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserPostModel? _userPosts;
  UserPostModel? get userPosts => _userPosts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Fetch posts for current user automatically using saved token
  Future<void> fetchUserPosts(int userId) async {
    if (_userPosts != null) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await SessionStorage().getToken();
      if (token == null) {
        _error = "User not authenticated";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Fetch a single UserPostModel
      _userPosts = await _authService.getUserPosts(userId, token);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearPosts() {
    _userPosts = null;
    notifyListeners();
  }
}
