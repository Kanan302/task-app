import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

class AppSnackBar {
  static void show(BuildContext context, String message,
      {Color backgroundColor = AppColors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
