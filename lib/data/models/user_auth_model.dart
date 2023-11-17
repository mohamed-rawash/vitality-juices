import 'package:drinks_app/domain/entities/user_auth_entities.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required super.uid,
    required super.userName,
    required super.email,
    required super.password,
    required super.phone,
    required super.createAt,
    required super.emailVerified,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        uid: json['uid'],
        userName: json['user_name'],
        email: json['email'],
        password: json['password'],
        phone: json['phone'],
        createAt: json['create_at'],
        emailVerified: json['email_verified'],
      );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'user_name': userName,
      'email': email,
      'password': password,
      'phone': phone,
      'create_at': createAt,
      'email_verified': emailVerified
    };
  }
}
