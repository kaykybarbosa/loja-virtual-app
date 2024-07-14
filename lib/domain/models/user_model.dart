// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isAdmin = false,
  });

  final String id;
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isAdmin;

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        password,
        confirmPassword,
        isAdmin,
      ];

  /// TODO: Criar service para salvar os dados no DB.
  DocumentReference get firebaseRef => FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartRef => firebaseRef.collection('cart');

  Future<void> saveData() async => await firebaseRef.set(toMapDB());

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        fullName: map['fullName'],
        email: map['email'],
        password: map['password'],
        confirmPassword: map['confirmPassword'],
      );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMapDB() => {
        'fullName': fullName,
        'email': email,
      };

  factory UserModel.fromMapDB(String documentId, Map<String, dynamic> document) => UserModel(
        id: documentId,
        fullName: document['fullName'] ?? '',
        email: document['email'] ?? '',
      );
}
