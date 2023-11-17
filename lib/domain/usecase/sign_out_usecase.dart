import 'package:dartz/dartz.dart';
import 'package:drinks_app/core/error/failure.dart';
import 'package:drinks_app/core/usecase/base_usecase.dart';
import 'package:drinks_app/domain/repository/base_user_auth_repository.dart';

class SignOutUseCase extends BaseUseCase<void, NoParameters> {
  BaseUserAuthRepository baseAuthRepository;

  SignOutUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, void>> call(NoParameters parameters) {
   return baseAuthRepository.signOut();
  }

}