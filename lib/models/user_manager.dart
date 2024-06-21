import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManager extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<void> signIn({
    required String email,
    required String password,
    Function()? onSuccess,
    Function(String error)? onFail,
  }) async {
    _setIsLoading(true);

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (onSuccess != null) onSuccess();
    } catch (e) {
      if (onFail != null) onFail('E-mail ou senha inválido');
    }

    _setIsLoading(false);
  }

  void _setIsLoading(bool value) {
    isLoading = value;

    notifyListeners();
  }
}
