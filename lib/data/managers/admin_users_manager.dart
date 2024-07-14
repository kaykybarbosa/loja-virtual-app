import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserModel> users = [];

  void updateUser(UserManager user) {
    if (user.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    final faker = Faker();

    for (int i = 0; i <= 100; i++) {
      users = List.from(users)
        ..add(
          UserModel(
            fullName: faker.person.name(),
            email: faker.internet.email(),
          ),
        );
    }

    users.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

    notifyListeners();
  }

  List<String> get strUsers => users.map((user) => user.fullName).toList();
}
