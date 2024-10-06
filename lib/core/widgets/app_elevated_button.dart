import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

// App üçün xüsusi ElevatedButton widgetı
class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // button eni tam ekran boyunca
      height: 50, // button hündürlüyü
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // button fon rəngi
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // button borderinin radiusu forması
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
