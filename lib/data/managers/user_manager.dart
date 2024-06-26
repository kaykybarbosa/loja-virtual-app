import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';
import 'package:lojavirtualapp/utils/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  bool _isLoading = false;
  UserModel? _currentUser;

  Future<void> _loadCurrentUser([User? firebaseUser]) async {
    final user = firebaseUser ?? _auth.currentUser;

    if (user != null) {
      final docUser = await _store.collection('users').doc(user.uid).get();

      currentUser = UserModel.fromMapDB(docUser.id, docUser.data() ?? {});
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    Function()? onSuccess,
    Function(String error)? onFail,
  }) async {
    _setIsLoading = true;

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _loadCurrentUser(result.user);

      if (onSuccess != null) onSuccess();
    } on FirebaseAuthException catch (e) {
      if (onFail != null) onFail(FirebaseErrors.getError(e.code, 'E-mail ou senha inválido'));
    } catch (e) {
      if (onFail != null) onFail('E-mail ou senha inválido');
    }

    _setIsLoading = false;
  }

  Future<void> signUp({
    required UserModel user,
    Function()? onSuccess,
    Function(String error)? onFail,
  }) async {
    _setIsLoading = true;
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: user.email, password: user.password);

      user = user.copyWith(id: result.user?.uid);

      currentUser = user;

      await user.saveData();

      if (onSuccess != null) onSuccess();
    } on FirebaseAuthException catch (e) {
      if (onFail != null) onFail(FirebaseErrors.getError(e.code));
    } catch (e) {
      if (onFail != null) onFail(e.toString());
    }

    _setIsLoading = false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // G E T T E R S
  bool get isLoading => _isLoading;

  UserModel? get getCurrentUser => _currentUser;

  bool get currentUserIsAuth => _currentUser != null;

  // S E T T E R S
  set _setIsLoading(bool value) => {_isLoading = value, notifyListeners()};

  set currentUser(UserModel user) => {_currentUser = user, notifyListeners()};
}
