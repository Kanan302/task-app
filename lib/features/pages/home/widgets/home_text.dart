import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/services/cubit/sort_cubit.dart';
import 'package:task/services/cubit/user_cubit.dart';

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

// Sıralama üçün başlıq metodu əlavə edirik
Widget buildSortableHeader(String title,
    {int flex = 1,
    required Map<String, dynamic> sortState,
    required BuildContext context}) {
  final sortColumn = sortState['sortColumn'];
  final ascending = sortState['ascending'];

  return Expanded(
    flex: flex,
    child: GestureDetector(
      onTap: () {
        context.read<SortCubit>().sort(title.toLowerCase());
        context
            .read<UserCubit>()
            .sortUsers(title.toLowerCase(), sortState['ascending']);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          if (sortColumn == title.toLowerCase())
            Icon(
              ascending ? Icons.arrow_upward : Icons.arrow_downward,
              color: AppColors.white,
              size: 16,
            ),
        ],
      ),
    ),
  );
}
