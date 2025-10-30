import 'package:blogs_app/Models/post_model.dart';
import 'package:blogs_app/Services/posts_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class PostProvider extends ChangeNotifier {
  final PostsService _postsService = PostsService();

  List<Posts> _posts = List.empty(growable: true);
  List<Posts> get posts => _posts;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPosts({bool force = false}) async {
    if (!force && _posts.isNotEmpty) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts.clear();
      final response = await _postsService.getPosts();
      final apiPosts = response.posts ?? [];

      final firestoreSnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .get();
      final firebasePosts = firestoreSnapshot.docs.map((doc) {
        final data = doc.data();
        return Posts(
          id: int.tryParse(data['id'] ?? ''),
          title: data['title'] ?? '',
          body: data['body'] ?? '',
        );
      }).toList();
      _posts = [...firebasePosts, ...apiPosts];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void deletePost(int index, {int? id}) async {
    _posts.removeAt(index);
    notifyListeners();
    try {
      // Delete from Firestore
      if (id != null) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(id.toString())
            .delete();
      }
    } catch (e) {
      // Handle error if needed
    }
  }
}
