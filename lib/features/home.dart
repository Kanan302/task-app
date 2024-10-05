import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/constants/app_routes.dart'; // Make sure this points to your route constants

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Firebase sign-out

    // Navigate back to the login page
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login.path,
      (route) => false, // Remove all routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context), // Call the logout function
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Home Page Content'),
        ),
      ),
    );
  }
}
