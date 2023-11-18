import 'package:dartz/dartz.dart';
import 'package:drinks_app/core/error/failure.dart';
import 'package:drinks_app/core/usecase/base_usecase.dart';
import 'package:drinks_app/domain/repository/base_user_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInUseCase extends BaseUseCase<User, NoParameters> {
  BaseUserAuthRepository baseUserAuthRepository;

  GoogleSignInUseCase(this.baseUserAuthRepository);

  @override
  Future<Either<Failure, User>> call(NoParameters parameters) {
    return baseUserAuthRepository.googleSignIn();
  }

}