import 'package:flutter/material.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/core/constants/app_texts.dart';

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppTexts.congrats),
      content: const Text(AppTexts.createdAccount),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.navbar.path);
          },
          child: const Text(AppTexts.close),
        ),
      ],
    );
  }
}
