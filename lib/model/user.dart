import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String pass;
  final String email;
  final String username;
  final int coin;
  final bool isAdmin;
  const UserModel(
      {required this.id,
      required this.coin,
      required this.pass,
      required this.email,
      required this.username,
      required this.isAdmin});
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': pass,
        'coin': coin,
        'isAdmin': isAdmin,
      };
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      coin: json['coin'],
      pass: json['password'],
      email: json['email'],
      username: json['username'],
      isAdmin: json['isAdmin']);
  @override
  List<Object?> get props => throw UnimplementedError();
}
