import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final bool _isSelected = false;
  bool get isSelected => _isSelected;

  void toggleLike() {
    _isSelected != _isSelected;
  }
}
