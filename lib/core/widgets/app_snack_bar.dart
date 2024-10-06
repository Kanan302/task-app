import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

// App-də istifadə olunan xüsusi Snackbar funksiyası
class AppSnackBar {
  static void show(BuildContext context, String message,
      {Color backgroundColor = AppColors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), // Snackbar-da göstərilən mesaj
        duration: const Duration(seconds: 3), // Snackbar-ın görünmə müddəti
        backgroundColor: backgroundColor, // Snackbar-ın fon rəngi
      ),
    );
  }
}
