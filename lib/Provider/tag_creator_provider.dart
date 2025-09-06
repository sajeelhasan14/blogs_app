import 'package:flutter/material.dart';

class TagCreatorProvider extends ChangeNotifier {
  final List<String> _tags = [];
  List<String> get tags => _tags;

  void addTag(String tag) {
    _tags.add(tag);

    notifyListeners();
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    notifyListeners();
  }
}
