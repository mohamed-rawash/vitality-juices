import 'package:drinks_app/core/usecase/base_usecase.dart';
import 'package:drinks_app/data/models/user_auth_model.dart';
import 'package:drinks_app/domain/entities/user_auth_entities.dart';
import 'package:drinks_app/domain/usecase/sign_in_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_out_usecase.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signUpUseCase, this.signInUseCase, this.signOutUseCase)
      : super(AuthInitial());

  SignUpUseCase signUpUseCase;
  SignInUseCase signInUseCase;
  SignOutUseCase signOutUseCase;

  static AuthCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();

  Future<void> signUp(SignUpParameters parameters) async {
    emit(SignUpLoadingState());
    final result = await signUpUseCase.call(parameters);
    result.fold(
      (l) => emit(SignUpErrorState(errorMessage: l.message)),
      (r) => emit(
        SignUpSuccessfulState(
          userAuthModel: UserAuthModel(
            uid: r.uid,
            userName: parameters.userName,
            email: parameters.email,
            password: parameters.password,
            phone: parameters.phone,
            createAt: r.metadata.creationTime.toString(),
            emailVerified: r.emailVerified,
          ),
        ),

      ),
    );
  }

  Future<void> signIn(SignInParameters parameters) async {
    emit(SignInLoadingState());
    final result = await signInUseCase.call(parameters);
    result.fold(
      (l) => emit(
        SignInErrorState(errorMessage: l.message),
      ),
      (r) => emit(
        const SignInSuccessfulState(),
      ),
    );
  }

  Future<void> signOut() async {
    final result = await signOutUseCase.call(const NoParameters());
    result.fold(
      (l) => emit(
        SignOutErrorState(l.message),
      ),
      (r) => emit(
        SignOutSuccessfulState(),
      ),
    );
  }
}
