import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/features/pages/home/widgets/home_search_field.dart';
import 'package:task/features/pages/home/widgets/home_text.dart';
import 'package:task/services/cubit/user_cubit.dart';
import 'package:task/services/cubit/sort_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.03),

          // Axtarış fieldi
          SearchField(
            text: AppTexts.search,
            onChanged: (query) {
              // Axtarış nəticələrini filtrləmək üçün UserCubit-dən istifadə
              context.read<UserCubit>().filterUsers(query);
            },
          ),

          const SizedBox(height: 20),

          // Cədvəl başlıqları
          Container(
            decoration: const BoxDecoration(
              color: AppColors.lightNavy,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: BlocBuilder<SortCubit, Map<String, dynamic>>(
                builder: (context, sortState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Sortable başlıqlar
                      buildSortableHeader(
                        AppTexts.firstName,
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        AppTexts.lastName,
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        AppTexts.email,
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        AppTexts.date,
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Divider(),

          // Jsondan gələn datalar
          Expanded(
            child: BlocBuilder<UserCubit, List<dynamic>>(
              builder: (context, users) {
                final userCubit = context.read<UserCubit>();

                // Yüklənmə zamanı göstərin
                if (userCubit.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // İstifadəçilər boşdursa, yüklənmə göstəricisi
                if (users.isEmpty) {
                  return const Center(child: Text(AppTexts.notFoundUser));
                  // return const Center(child: CircularProgressIndicator());
                }
                // İstifadəçilərin siyahısını göstər
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // İstifadəçi məlumatlarını göstər
                          buildItemText(user['name'], flex: 2),
                          buildItemText(user['surname'], flex: 2),
                          buildItemText(user['email'], flex: 3),
                          buildItemText(user['registeredDate'], flex: 2),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
