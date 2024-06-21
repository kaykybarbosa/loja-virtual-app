import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
