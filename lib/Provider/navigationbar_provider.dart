import 'package:flutter/material.dart';

class NavigationbarProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void toggleIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
