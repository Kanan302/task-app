import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

// Başlıq mətni üçün metodu istifadə edirik
Widget buildHeaderText(String text, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white, // Başlıqların rəngi
        ),
      ),
    ),
  );
}

// Məlumatın göstərilməsi üçün metodu istifadə edirik
Widget buildItemText(String? text,
    {int flex = 1, TextAlign align = TextAlign.start}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        text ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: align,
        style: const TextStyle(
          color: AppColors.black, // Məlumatların rəngi
        ),
      ),
    ),
  );
}
