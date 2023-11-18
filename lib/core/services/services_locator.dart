import 'package:drinks_app/data/datasource/user_auth_remote_data_source.dart';
import 'package:drinks_app/data/repository/user_auth_repository.dart';
import 'package:drinks_app/domain/repository/base_user_auth_repository.dart';
import 'package:drinks_app/domain/usecase/google_sign_in_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_in_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_out_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:drinks_app/presentation/controller/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init(){
    //cubits
    sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
    //use cases
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => SignOutUseCase(sl()));
    sl.registerLazySingleton(() => GoogleSignInUseCase(sl()));
    //repository
    sl.registerLazySingleton<BaseUserAuthRepository>(() => UserAuthRepository(sl()));
    // datasource
    sl.registerLazySingleton<BaseUserAuthRemoteDataSource>(() => UserAuthRemoteDataSource());
  }
}
