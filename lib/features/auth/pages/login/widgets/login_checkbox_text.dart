import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/visibility_provider.dart';

class LoginCheckboxText extends StatelessWidget {
  final String text;
  const LoginCheckboxText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<VisibilityProvider>(
          builder: (context, visibilityProvider, child) {
            return Checkbox(
              value: visibilityProvider.isRememberMeChecked,
              onChanged: (bool? value) {
                visibilityProvider.toggleRememberMe();
              },
            );
          },
        ),
        Text(text),
      ],
    );
  }
}
