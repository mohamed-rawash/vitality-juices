import 'package:drinks_app/core/utils/enums.dart';
import 'package:drinks_app/data/models/user_auth_model.dart';
import 'package:drinks_app/domain/entities/user_auth_entities.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class SignUpSuccessfulState extends AuthState {
  final UserAuthModel userAuthModel;

  const SignUpSuccessfulState({required this.userAuthModel});

  @override
  List<Object?> get props => [userAuthModel];
}
class SignUpErrorState extends AuthState {
  final String errorMessage;

  const SignUpErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class SignInLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class SignInSuccessfulState extends AuthState {

  const SignInSuccessfulState();

  @override
  List<Object?> get props => [];
}
class SignInErrorState extends AuthState {
  final String errorMessage;

  const SignInErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class GoogleSignInLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}
class GoogleSignInSuccessfulState extends AuthState {
  final UserAuthModel userAuthModel;

  const GoogleSignInSuccessfulState({required this.userAuthModel});

  @override
  List<Object?> get props => [userAuthModel];
}
class GoogleSignInErrorState extends AuthState {
  final String errorMessage;

  const GoogleSignInErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class SignOutSuccessfulState extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SignOutErrorState extends AuthState{
  final String errorMessage;

  const SignOutErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

