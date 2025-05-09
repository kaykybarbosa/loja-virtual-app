import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserModel> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> get strUsers =>
      users.map((user) => user.fullName.capitalizeFirst).toList();

  void updateUser(UserManager user) {
    if (user.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((e) => UserModel.fromMapDB(e.id, e.data())).toList();

      users.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

      notifyListeners();
    });
  }
}

extension StringExtension on String {
  String get capitalizeFirst =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String get capitalizeAll {
    final values = split(' ');

    if (values.isEmpty) return this;

    final buffer = StringBuffer();
    for (final value in values) {
      final bool isLast = value == values.last;

      buffer.write('${value.capitalizeFirst}${(isLast ? '' : ' ')}');
    }

    return buffer.toString();
  }
}
