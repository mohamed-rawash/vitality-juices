import 'package:dartz/dartz.dart';
import 'package:drinks_app/core/error/exception.dart';
import 'package:drinks_app/domain/repository/base_user_auth_repository.dart';
import 'package:drinks_app/domain/usecase/sign_in_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/failure.dart';
import '../datasource/user_auth_remote_data_source.dart';

class UserAuthRepository extends BaseUserAuthRepository {
  BaseUserAuthRemoteDataSource userAuthRemoteDataSource;

  UserAuthRepository(this.userAuthRemoteDataSource);

  @override
  Future<Either<Failure, void>> facebookSignIn() {
    // TODO: implement facebookSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> githubSignIn() {
    // TODO: implement githubSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> googleSignIn() async {
    try {
      final result = await userAuthRemoteDataSource.googleSignIn();
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(message: failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParameters parameters) async {
    try {
      final result = await userAuthRemoteDataSource.signIn(parameters);
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(message: failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await userAuthRemoteDataSource.signOut();
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(message: failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpParameters parameters) async {
    try {
      final result = await userAuthRemoteDataSource.signUp(parameters);
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(message: failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> twitterSignIn() {
    // TODO: implement twitterSignIn
    throw UnimplementedError();
  }

}
