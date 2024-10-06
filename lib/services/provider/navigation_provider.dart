import 'package:flutter/foundation.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0; // Seçilmiş indeksin başlanğıc dəyəri

  // Seçilmiş indeksi əldə etmək üçün getter
  int get selectedIndex => _selectedIndex;

  // İndeksi təyin edən metod
  void setIndex(int index) {
    _selectedIndex =
        index; // Verilən indeksi `_selectedIndex` dəyişəninə təyin et
    notifyListeners();
  }
}
