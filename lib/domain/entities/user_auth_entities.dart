import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  final String uid;
  final String userName;
  final String email;
  final String password;
  final String phone;
  final String createAt;
  final bool emailVerified;

  const UserAuth({
    required this.uid,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.createAt,
    required this.emailVerified,
  });

  static const UserAuth empty = UserAuth(
    uid: '',
    userName: '',
    email: '',
    password: '',
    phone: '',
    createAt: "",
    emailVerified: false,
  );

  bool get isEmpty => this == UserAuth.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        userName,
        email,
        password,
        phone,
        createAt,
        emailVerified,
      ];
}
