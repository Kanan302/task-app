import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/services/provider/visibility_provider.dart';

// "Məni xatırla" checkbox-u və mətni olan widget
class LoginCheckboxText extends StatelessWidget {
  final String text; // Checkbox-un yanındakı mətn

  const LoginCheckboxText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox üçün görünürlük provider-i
        Consumer<VisibilityProvider>( 
          builder: (context, visibilityProvider, child) {
            return Checkbox(
              value: visibilityProvider.isRememberMeChecked, // Checkbox-un dəyəri
              onChanged: (bool? value) {
                visibilityProvider.toggleRememberMe(); // Checkbox-u dəyişdirdikdə dəyəri dəyiş
              },
            );
          },
        ),
        Text(text), // "Məni xatırla" mətni
      ],
    );
  }
}
