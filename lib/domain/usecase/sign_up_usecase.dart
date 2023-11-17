import 'package:dartz/dartz.dart';
import 'package:drinks_app/core/error/failure.dart';
import 'package:drinks_app/core/usecase/base_usecase.dart';
import 'package:drinks_app/domain/repository/base_user_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpUseCase extends BaseUseCase<User, SignUpParameters> {
  BaseUserAuthRepository baseAuthRepository;

  SignUpUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, User>> call(SignUpParameters parameters) {
    return baseAuthRepository.signUp(
      parameters
    );
  }
}

class SignUpParameters extends Equatable {
  final String email;
  final String password;
  final String userName;
  final String phone;

  const SignUpParameters({
    required this.email,
    required this.password,
    required this.userName,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, userName, phone];
}
