import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/core/widgets/app_snack_bar.dart';
import 'package:task/features/pages/profile/model/user_model.dart';

Future<void> fetchProfileHelper({
  required BuildContext context,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController ageController,
  required TextEditingController addressController,
  required Function(String?) onImageFetched,
  required Function(String?) onProfileDocIdFetched,
}) async {
  try {
    final user = FirebaseAuth.instance
        .currentUser; // Hal-hazırda autentikasiya olunmuş istifadəçini əldə et.
    if (user != null) {
      // Firestore-dan istifadəçi profil məlumatlarını əldə etmək üçün sorğu göndər.
      final snapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        
        final data = snapshot.docs.first.data(); // İlk sənədin məlumatlarını əldə et.
        onProfileDocIdFetched(snapshot.docs.first.id); // Sənəd ID-sini əldə et.

        firstNameController.text = data['first_name'] ?? '';
        lastNameController.text = data['last_name'] ?? '';
        ageController.text = data['age'] ?? '';
        addressController.text = data['address'] ?? '';
        final base64Image = data['image_base64'] ?? '';
        onImageFetched(base64Image.isNotEmpty ? base64Image : null); // Şəkil varsa onu əldə et.
      }
    }
  } catch (e) {
    AppSnackBar.show(
      context,
      AppTexts.notFoundProfile, // Profil tapılmadı xəbərdarlığını göstər.
    );
  }
}

Future<void> pickImageHelper({
  required ImagePicker picker,
  required Function(Uint8List?) onImagePicked,
  required Function(String?) onBase64ImageSet,
}) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Qalereyadan şəkil seç.
  if (pickedFile != null) {
    final imageFile = File(pickedFile.path);
    final bytes = imageFile.readAsBytesSync();
    onBase64ImageSet(base64Encode(bytes)); // Şəkili base64 formatına çevir.
    onImagePicked(bytes); // Şəkili əldə et.
  }
}

Future<void> saveProfileHelper({
  required BuildContext context,
  required UserProfile userProfile,
  required String? base64Image,
  required String? profileDocId,
}) async {
  if (base64Image != null) {
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(profileDocId)
        .set({
      'first_name': userProfile.firstName,
      'last_name': userProfile.lastName,
      'age': userProfile.age,
      'address': userProfile.address,
      'image_base64': base64Image,
      'user_id': FirebaseAuth.instance.currentUser!.uid,
    }, SetOptions(merge: true)); // Profil məlumatlarını yenilə.
    AppSnackBar.show(
      context,
      AppTexts.savedProfile,
      backgroundColor: AppColors.black,
    );
  } else {
    AppSnackBar.show(
      context,
      AppTexts.notLoadedImage, // Şəkil yüklənməyibsə xəbərdarlıq göstər.
      backgroundColor: AppColors.black,
    );
  }
}

Future<void> deleteProfileHelper({
  required BuildContext context,
  required String? profileDocId,
  required Function() onLogout,
}) async {
  if (profileDocId != null) {
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(profileDocId)
        .delete(); // Profil sənədini sil.
    AppSnackBar.show(
      context,
      AppTexts.deletedProfile, // Profil silindi xəbərdarlığını göstər.
      backgroundColor: AppColors.black,
    );
    onLogout();
  }
}
