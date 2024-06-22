import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  bool _loading = false;
  User? _currentUser;

  Future<void> signIn({
    required String email,
    required String password,
    Function()? onSuccess,
    Function(String error)? onFail,
  }) async {
    loading = true;

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser = result.user!;

      if (onSuccess != null) onSuccess();
    } catch (e) {
      if (onFail != null) onFail('E-mail ou senha inválido');
    }

    loading = false;
  }

  void _loadCurrentUser() {
    final user = _auth.currentUser;

    if (user != null) {
      currentUser = user;
    }
  }

  // G E T T E R S
  bool get isLoading => _loading;

  User? get getCurrentUser => _currentUser;

  // S E T T E R S
  set loading(bool value) => {_loading = value, notifyListeners()};

  set currentUser(User user) => {_currentUser = user, notifyListeners(), log(user.uid)};
}
