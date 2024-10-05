import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _isObscuredPassword = true;
  bool _isObscuredConfirmPassword = true;
  bool _isRememberMeChecked = false;

  bool get isObscuredPassword => _isObscuredPassword;
  bool get isObscuredConfirmPassword => _isObscuredConfirmPassword;
  bool get isRememberMeChecked => _isRememberMeChecked;

  void togglePasswordVisibility() {
    _isObscuredPassword = !_isObscuredPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isObscuredConfirmPassword = !_isObscuredConfirmPassword;
    notifyListeners();
  }

  void toggleRememberMe() {
    _isRememberMeChecked = !_isRememberMeChecked;
    notifyListeners();
  }
}
