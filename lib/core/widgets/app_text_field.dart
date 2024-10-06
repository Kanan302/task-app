import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

// App-də istifadə olunan xüsusi mətn sahəsi (TextField) widgetı
class AppTextField extends StatelessWidget {
  final String hintText; // Mətn sahəsində görünən köməkçi mətn
  final TextEditingController controller; // Mətn sahəsinin idarəedici obyekti
  final bool obscureText; // Mətnin gizlədilməsini idarə edir (şifrə sahəsi üçün)
  final IconData prefixIcon; // Mətn sahəsinin başındakı ikon
  final VoidCallback? onPressed; // İkon düyməsi basıldıqda yerinə yetiriləcək funksiya
  final String? Function(String?)? validator; // Daxil edilən mətni yoxlayan funksiya

  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.prefixIcon,
    required this.onPressed,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress, 
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.lightGray,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Icon(prefixIcon), 
        ),
        suffixIcon: onPressed != null
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility, // Gizli mətni göstərmək/diskret etmək üçün ikon
                  ),
                  onPressed: onPressed, 
                ),
              )
            : null,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black), 
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey700), 
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black), 
        ),
      ),
      obscureText: obscureText, // Mətnin gizlədilməsi
      controller: controller, 
      obscuringCharacter: obscureText ? '•' : ' ', // Gizli mətndəki simvol
      validator: validator, // Mətnin doğruluğunu yoxlayan funksiya
    );
  }
}
