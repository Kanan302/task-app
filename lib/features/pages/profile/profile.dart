import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/features/pages/profile/services/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  icon: const Icon(Icons.logout, color: AppColors.black),
                  onPressed: () => provider.logout(context),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: provider.pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: provider.imageBytes == null
                              ? null
                              : MemoryImage(provider.imageBytes!),
                          child: provider.imageBytes == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: provider.firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: provider.lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: provider.ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: provider.addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => provider
                                .deleteProfile(context), // Pass context here
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightNavy,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text('Delete'),
                          ),
                          ElevatedButton(
                            onPressed: () => provider
                                .saveProfile(context), // Pass context here
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightNavy,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
