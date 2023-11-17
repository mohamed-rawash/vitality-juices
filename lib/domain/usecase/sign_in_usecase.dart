import 'package:dartz/dartz.dart';
import 'package:drinks_app/core/error/failure.dart';
import 'package:drinks_app/core/usecase/base_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repository/base_user_auth_repository.dart';

class SignInUseCase extends BaseUseCase<User, SignInParameters> {
  BaseUserAuthRepository baseAuthRepository;

  SignInUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, User>> call(SignInParameters parameters) {
    return baseAuthRepository.signIn(parameters);
  }

}
class SignInParameters extends Equatable {
  final String email;
  final String password;


  const SignInParameters({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}