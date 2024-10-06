import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

class RegisterTextDetector extends StatelessWidget {
  final String text; // Üzv olmayan mesajı
  final GestureTapCallback onTap; // Tıklama hadisəsi
  final String loginText; // "Daxil ol" mətni

  const RegisterTextDetector({
    super.key,
    required this.text,
    required this.onTap,
    required this.loginText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Text(
          text, 
          style: const TextStyle(
            color: AppColors.black, 
            fontSize: 14, 
          ),
        ),
        GestureDetector(
          onTap: onTap, 
          child: Text(
            loginText, // "Daxil ol" mətni
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
