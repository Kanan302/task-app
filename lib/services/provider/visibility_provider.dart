import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _isObscuredPassword = true; // Şifrə görünməzliyinin başlanğıc dəyəri
  bool _isObscuredConfirmPassword =
      true; // Təkrar şifrə görünməzliyinin başlanğıc dəyəri
  bool _isRememberMeChecked =
      false; // "Məni yadda saxla" seçiminin başlanğıc dəyəri

  bool get isObscuredPassword => _isObscuredPassword;
  bool get isObscuredConfirmPassword => _isObscuredConfirmPassword;
  bool get isRememberMeChecked => _isRememberMeChecked;

  // Şifrə görünməzliyini dəyişdirmək üçün metod
  void togglePasswordVisibility() {
    _isObscuredPassword = !_isObscuredPassword;
    notifyListeners();
  }

  // Təkrar şifrə görünməzliyini dəyişdirmək üçün metod
  void toggleConfirmPasswordVisibility() {
    _isObscuredConfirmPassword = !_isObscuredConfirmPassword;
    notifyListeners();
  }

  // "Məni yadda saxla" seçiminin vəziyyətini dəyişdirmək üçün metod
  void toggleRememberMe() {
    _isRememberMeChecked = !_isRememberMeChecked;
    notifyListeners();
  }
}
