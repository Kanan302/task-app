import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/constants/app_routes.dart';
import 'package:task/features/pages/profile/model/user_model.dart';
import 'package:task/features/pages/profile/services/profile_helper.dart';

class ProfileProvider extends ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? base64Image; // Şəklin base64 formatında saxlanması
  Uint8List? imageBytes; // Şəkinin byte formatında saxlanması
  String? profileDocId; // Firestore-da profil sənədinin ID-si
  bool isLoading = true; 

  final ImagePicker _picker = ImagePicker();

  // Constructor, profil məlumatlarını yükləmək üçün çağırılır
  ProfileProvider(BuildContext context) {
    _fetchProfile(context); // Profil məlumatlarını yükləyir
  }

  // Profil məlumatlarını yükləmək üçün helper funksiyası
  Future<void> _fetchProfile(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    // Profil məlumatlarını Firestore-dan yükləyir
    await fetchProfileHelper(
      context: context,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      ageController: ageController,
      addressController: addressController,
      onImageFetched: (String? imageBase64) {
        if (imageBase64 != null) {
          base64Image = imageBase64; // Şəklin base64 formatını saxla
          imageBytes = base64Decode(base64Image!); // Base64-dan byte formatına çevir
        }
        notifyListeners();
      },
      onProfileDocIdFetched: (String? docId) {
        profileDocId = docId; // Profil sənədinin ID-sini saxla
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  // İstifadəçidən şəkil seçmək üçün metod
  Future<void> pickImage() async {
    await pickImageHelper(
      picker: _picker,
      onImagePicked: (Uint8List? imageBytes) {
        this.imageBytes = imageBytes; // Seçilmiş şəkli saxla
        notifyListeners();
      },
      onBase64ImageSet: (String? base64) {
        base64Image = base64; // Seçilmiş şəkli base64 formatında saxla
        notifyListeners();
      },
    );
  }

  // İstifadəçi profilini saxlamaq üçün metod
  Future<void> saveProfile(BuildContext context) async {
    UserProfile userProfile = UserProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      age: ageController.text,
      address: addressController.text,
      imageBase64: base64Image ?? '',
    );

    // Profil məlumatlarını Firestore-a qeyd et
    await saveProfileHelper(
      context: context,
      userProfile: userProfile,
      base64Image: base64Image,
      profileDocId: profileDocId,
    );
  }

  // Profil məlumatlarını silmək üçün metod
  Future<void> deleteProfile(BuildContext context) async {
    await deleteProfileHelper(
      context: context,
      profileDocId: profileDocId,
      onLogout: () => logout(context), // Profil silindikdən sonra çıxış et
    );
  }

  // İstifadəçini çıxış etdirmək üçün metod
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Firebase-dən çıxış et
    Navigator.pushReplacementNamed(context, AppRoutes.login.path); // Login səhifəsinə yönləndir
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
