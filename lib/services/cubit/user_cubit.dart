import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class UserCubit extends Cubit<List<dynamic>> {
  UserCubit() : super([]);

  List<dynamic> _users = []; // İstifadəçi məlumatlarını saxlamaq üçün dəyişən

  // İstifadəçiləri yükləmək üçün metodu
  Future<void> loadUsers() async {
    final String response =
        await rootBundle.loadString('assets/json/user.json');
    final data = await json
        .decode(response); // JSON məlumatını parçalayıb Dart obyektinə çevirin

    _users = data['users']; // İstifadəçiləri _users dəyişəninə təyin edin
    emit(
        _users); // İstifadəçiləri emit edin (müvafiq BlocBuilder-da yeniləmə üçün)
  }

  void filterUsers(String query) {
    final lowerCaseQuery =
        query.toLowerCase(); // Axtarış sorğusunu kiçik hərflərə çevirin
    final filteredUsers = _users.where((user) {
      // İstifadəçi adını, soyadını və elektron poçtunu axtarış sorğusuna görə filter edin
      final name = user['name'].toLowerCase();
      final surname = user['surname'].toLowerCase();
      final email = user['email'].toLowerCase();
      return name.contains(lowerCaseQuery) ||
          surname.contains(lowerCaseQuery) ||
          email.contains(lowerCaseQuery);
    }).toList();

    emit(filteredUsers);
  }

  void sortUsers(String column, bool ascending) {
    final sortedUsers =
        List.from(_users); // Müvafiq istifadəçilərin surətini yaradın

    // İstifadəçiləri verilmiş sütuna görə sıralayın
    sortedUsers.sort((a, b) {
      final aValue = a[column].toString();
      final bValue = b[column].toString();

      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    emit(sortedUsers);
  }
}
