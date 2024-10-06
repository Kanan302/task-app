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

  String? base64Image;
  Uint8List? imageBytes;
  String? profileDocId;
  bool isLoading = true; // Track loading state

  final ImagePicker _picker = ImagePicker();

  ProfileProvider(BuildContext context) {
    _fetchProfile(context);
  }

  Future<void> _fetchProfile(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await fetchProfileHelper(
      context: context,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      ageController: ageController,
      addressController: addressController,
      onImageFetched: (String? imageBase64) {
        if (imageBase64 != null) {
          base64Image = imageBase64;
          imageBytes = base64Decode(base64Image!);
        }
        notifyListeners();
      },
      onProfileDocIdFetched: (String? docId) {
        profileDocId = docId;
        notifyListeners();
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> pickImage() async {
    await pickImageHelper(
      picker: _picker,
      onImagePicked: (Uint8List? imageBytes) {
        this.imageBytes = imageBytes;
        notifyListeners();
      },
      onBase64ImageSet: (String? base64) {
        base64Image = base64;
        notifyListeners();
      },
    );
  }

  Future<void> saveProfile(BuildContext context) async {
    UserProfile userProfile = UserProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      age: ageController.text,
      address: addressController.text,
      imageBase64: base64Image ?? '',
    );

    await saveProfileHelper(
      context: context,
      userProfile: userProfile,
      base64Image: base64Image,
      profileDocId: profileDocId,
    );
  }

  Future<void> deleteProfile(BuildContext context) async {
    await deleteProfileHelper(
      context: context,
      profileDocId: profileDocId,
      onLogout: () => logout(context),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.login.path);
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
