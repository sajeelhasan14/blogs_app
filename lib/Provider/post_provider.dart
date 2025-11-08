import 'package:blogs_app/Models/post_model.dart';
import 'package:blogs_app/Services/posts_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class PostProvider extends ChangeNotifier {
  final PostsService _postsService = PostsService();

  List<Posts> _posts = List.empty(growable: true);
  List<Posts> get posts => _posts;

  List<Posts> _firebasePosts = List.empty(growable: true);
  List<Posts> get firebasePosts => _firebasePosts;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  PostProvider() {
    _listenToFirebasePosts(); // Start real-time listener on initialization
  }

  void _listenToFirebasePosts() {
    FirebaseFirestore.instance
        .collection("posts")
        .snapshots()
        .listen(
          (snapshot) async {
            // Convert Firestore docs to Posts
            _firebasePosts = snapshot.docs.map((doc) {
              final data = doc.data();
              return Posts(
                id: int.tryParse(data['id'] ?? ''),
                title: data['title'] ?? '',
                body: data['body'] ?? '',
              );
            }).toList();

            // Merge with API posts
            final response = await _postsService.getPosts();
            final apiPosts = response.posts ?? [];
            _posts = [..._firebasePosts, ...apiPosts];

            _isLoading = false;
            notifyListeners(); // UI updates automatically
          },
          onError: (e) {
            _error = e.toString();
            _isLoading = false;
            notifyListeners();
          },
        );
  }

  Future<void> fetchPosts({bool force = false}) async {
    if (!force && _posts.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _postsService.getPosts();
      final apiPosts = response.posts ?? [];
      _posts = [..._firebasePosts, ...apiPosts];
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void deletePost(int index, {int? id}) async {
    if (index >= 0 && index < _posts.length) {
      _posts.removeAt(index);
      notifyListeners();
    }

    try {
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
