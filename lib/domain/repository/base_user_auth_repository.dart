import 'package:dartz/dartz.dart';
import 'package:drinks_app/domain/usecase/sign_in_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/failure.dart';

abstract class BaseUserAuthRepository {
  Future<Either<Failure, User>> signUp(SignUpParameters parameters);
  Future<Either<Failure, User>> signIn(SignInParameters parameters);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> googleSignIn();
  Future<Either<Failure, void>> githubSignIn();
  Future<Either<Failure, void>> facebookSignIn();
  Future<Either<Failure, void>> twitterSignIn();
}