import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

// Giriş mətni ilə qeydiyyat düyməsi arasında keçid yaradan widget
class LoginTextDetector extends StatelessWidget {
  final String text; // Giriş mətni
  final GestureTapCallback onTap; // Qeydiyyat mətni üçün tap callback-i
  final String registerText; // Qeydiyyat mətni

  const LoginTextDetector({
    super.key,
    required this.text,
    required this.onTap,
    required this.registerText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.black, // Mətnin rəngi
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: onTap, // Qeydiyyat mətni basıldığında callback
          child: Text(
            registerText,
            style: const TextStyle(
              color: AppColors.lightNavy, 
              fontSize: 14,
              fontWeight: FontWeight.bold, 
            ),
          ),
        )
      ],
    );
  }
}
