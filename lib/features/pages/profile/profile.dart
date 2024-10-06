import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/features/pages/profile/services/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppTexts.profile),
          backgroundColor: Colors.transparent,
          elevation: 0, // Kölgə olmaması üçün
          actions: [
            Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  icon: const Icon(Icons.logout, color: AppColors.black),
                  onPressed: () => provider.logout(context), // Çıxış əmri
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
                  if (provider.isLoading) {
                    // Yüklənmə zamanı göstərin
                    return const CircularProgressIndicator();
                  }

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: provider
                            .pickImage, // Şəkil seçmə funksiyasını çağır
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: provider.imageBytes == null
                              ? null
                              : MemoryImage(
                                  provider.imageBytes!), // Şəkili byte-dan çək
                          child: provider.imageBytes == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Ad
                      TextField(
                        controller: provider.firstNameController,
                        decoration: const InputDecoration(
                          labelText: AppTexts.firstName,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Soyad
                      TextField(
                        controller: provider.lastNameController,
                        decoration: const InputDecoration(
                          labelText: AppTexts.lastName,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Yaş
                      TextField(
                        controller: provider.ageController,
                        decoration: const InputDecoration(
                          labelText: AppTexts.age,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Ünvan
                      TextField(
                        controller: provider.addressController,
                        decoration: const InputDecoration(
                          labelText: AppTexts.address,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => provider.deleteProfile(context), // Profil silmə əmri
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightNavy,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text(AppTexts.delete),
                          ),
                          ElevatedButton(
                            onPressed: () => provider.saveProfile(context), // Profil saxlama əmri
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightNavy,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text(AppTexts.save),
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
