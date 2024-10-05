import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:task/core/constants/app_routes.dart';

// ignore_for_file: use_build_context_synchronously
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void _logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();

  //   // mounted yoxlaması ilə təhlükəsiz Context istifadə edin

  //   if (mounted) {
  //     Navigator.pushReplacementNamed(context, AppRoutes.login.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page Content'),
    );
  }
}
