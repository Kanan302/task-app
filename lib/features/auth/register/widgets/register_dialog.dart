import 'package:flutter/material.dart';
import 'package:task/core/constants/app_routes.dart';

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Təbriklər!'),
      content: const Text('Hesab yaradıldı! Təbrik edirik!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.navbar.path);
          },
          child: const Text('Bağla'),
        ),
      ],
    );
  }
}
