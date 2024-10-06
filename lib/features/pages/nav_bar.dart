import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/constants/app_texts.dart';
import 'package:task/features/pages/home/home.dart';
import 'package:task/services/provider/navigation_provider.dart';
import 'profile/profile.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // NavigationProvider-in nümunəsini alır
    final navigationProvider = Provider.of<NavigationProvider>(context);

    // Səhifələr siyahısı
    final List<Widget> pages = [
      const HomePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(
        child:
            pages[navigationProvider.selectedIndex], // Seçilmiş səhifəni göstər
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppTexts.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppTexts.profile,
          ),
        ],
        currentIndex: navigationProvider.selectedIndex, // Aktiv səhifəni göstər
        onTap: (index) =>
            navigationProvider.setIndex(index), // Yeni səhifə seçimi
      ),
    );
  }
}
