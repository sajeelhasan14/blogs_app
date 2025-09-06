import 'package:blogs_app/Models/tags_stories_model.dart';

import 'package:blogs_app/Services/tags_stories.dart';
import 'package:flutter/material.dart';

class TagsStoriesProvider extends ChangeNotifier {
  final TagsStoriesService _storiesService = TagsStoriesService();
  List<Posts> _tagsData = List.empty(growable: true);
  List<Posts> get tagsData => _tagsData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchTagsData(String tag) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _storiesService.getTagsData(tag);
      _tagsData = response.posts ?? [];
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  int _selectedIndex = 0; // default index
  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void updateSearchQuery(String input) {
    _searchQuery = input;
    notifyListeners();
  }

  List<Posts> get search {
    if (_searchQuery.isEmpty) return _tagsData;
    return _tagsData.where((query) {
      return query.title!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          query.body!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }
}
