import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/app_colors.dart';
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
            text: 'Search',
            onChanged: (query) {
              context.read<UserCubit>().filterUsers(query);
            },
          ),

          const SizedBox(height: 20),

          // Cədvəl başlıqları
          Container(
            decoration: const BoxDecoration(
              color: AppColors.blue,
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
                      buildSortableHeader(
                        'Name',
                        flex: 1,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        'Surname',
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        'Email',
                        flex: 2,
                        sortState: sortState,
                        context: context,
                      ),
                      buildSortableHeader(
                        'Date',
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
                if (users.isEmpty) {
                  return const Center(
                    child: Text('No users found'),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
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
