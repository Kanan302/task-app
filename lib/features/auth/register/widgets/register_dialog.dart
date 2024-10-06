import 'package:flutter/material.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/core/constants/app_texts.dart';

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog( // Dialoq pəncərəsi
      title: const Text(AppTexts.congrats), // Dialoq başlığı
      content: const Text(AppTexts.createdAccount), // Dialoq məzmunu
      actions: [
        TextButton(
          onPressed: () {
            // İstifadəçi buttona basdıqda
            Navigator.pushReplacementNamed(context, AppRoutes.navbar.path); // Navbar səhifəsinə keçid
          },
          child: const Text(AppTexts.close), 
        ),
      ],
    );
  }
}
