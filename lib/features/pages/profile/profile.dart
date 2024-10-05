import 'dart:convert';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/constants/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = '';
  String lastName = '';
  String age = ''; // Age field
  String address = ''; // Ünvan field
  String? base64Image; // Base64 formatında şəkil
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        final bytes = _image!.readAsBytesSync();
        base64Image = base64Encode(bytes); // Şəkli base64 formatına çeviririk
      });
    }
  }

  // Future<void> saveProfile(UserProfile userProfile) async {
  //   if (base64Image != null) {
  //     await FirebaseFirestore.instance.collection('profiles').add({
  //       'first_name': userProfile.firstName,
  //       'last_name': userProfile.lastName,
  //       'age': userProfile.age,
  //       'address': userProfile.address,
  //       'image_base64': base64Image, // Şəkili base64 formatında saxlayırıq
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Profil saxlanıldı!')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Şəkil yükləyin!')),
  //     );
  //   }
  // }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.login.path);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image == null ? null : FileImage(_image!),
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() {
                firstName = value;
              }),
              decoration: const InputDecoration(labelText: 'Ad'),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => setState(() {
                lastName = value;
              }),
              decoration: const InputDecoration(labelText: 'Soyad'),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => setState(() {
                age = value;
              }),
              decoration: const InputDecoration(labelText: 'Yaş'),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => setState(() {
                address = value;
              }),
              decoration: const InputDecoration(labelText: 'Ünvan'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // UserProfile userProfile = UserProfile(
                //   firstName: firstName,
                //   lastName: lastName,
                //   age: age,
                //   address: address,
                //   imageBase64: base64Image ?? '', // Base64 şəkli userProfile-də saxla
                // );
                // saveProfile(userProfile);
              },
              child: const Text('Saxla'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Çıxış'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  String firstName;
  String lastName;
  String age;
  String address;
  String imageBase64; // Base64 formatında şəkil

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.imageBase64,
  });
}
