import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void toggleVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }
}
