import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class UserCubit extends Cubit<List<dynamic>> {
  UserCubit() : super([]);

  List<dynamic> _users = [];

  Future<void> loadUsers() async {
    final String response =
        await rootBundle.loadString('assets/json/user.json');
    final data = await json.decode(response);

    _users = data['users'];
    emit(_users);
  }

  void filterUsers(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final filteredUsers = _users.where((user) {
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
    final sortedUsers = List.from(_users);

    sortedUsers.sort((a, b) {
      final aValue = a[column].toString();
      final bValue = b[column].toString();

      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    emit(sortedUsers);
  }
}
