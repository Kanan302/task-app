import 'package:flutter/material.dart';

// App-də istifadə olunan xüsusi TextButton widgetı
class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // düymə basıldıqda yerinə yetiriləcək funksiya
      child: Text(
        text,
        style: TextStyle(
          color: color, // mətn rəngi
        ),
      ),
    );
  }
}
