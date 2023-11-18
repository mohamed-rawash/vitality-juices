import 'package:drinks_app/core/utils/colors.dart';
import 'package:drinks_app/core/utils/extentsions.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:drinks_app/presentation/components/custom_auth_background.dart';
import 'package:drinks_app/presentation/controller/auth/auth_cubit.dart';
import 'package:drinks_app/presentation/controller/auth/auth_state.dart';
import 'package:drinks_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/global/route_transition.dart';
import '../../components/app_logo.dart';
import '../../components/auth_button.dart';
import '../../components/custom_auth_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccessfulState) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Welcome ${state.userAuthModel.userName}",
              style: const TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.green,
            behavior: SnackBarBehavior.floating,
          ),);
        }
        if (state is SignUpErrorState) {
          final snackBar = SnackBar(
            content: Text(
              state.errorMessage,
              style: const TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              const CustomAuthBackground(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppLogo(),
                          const Text(
                            "Register Now",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                              color: AppColors.darkPurple,
                            ),
                          ),
                          const Text(
                            "Enter your personal information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomAuthTextField(
                            title: "User Name",
                            controller: cubit.userName,
                          ),
                          CustomAuthTextField(
                            title: "Email",
                            controller: cubit.email,
                            validator: (val) {
                              if (val!.isValidEmail) {
                                return null;
                              } else {
                                return "Please enter a valid email";
                              }
                            },
                          ),
                          CustomAuthTextField(
                            title: "Phone Number",
                            controller: cubit.phone,
                          ),
                          CustomAuthTextField(
                            title: "Password",
                            controller: cubit.password,
                            show: true,
                            validator: (val) {
                              if (val!.isValidPassword) {
                                return null;
                              } else {
                                return "This password not Valid";
                              }
                            },
                          ),
                          CustomAuthTextField(
                            title: "Confirm Password",
                            controller: email,
                            show: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthButton(
                            text: "Register",
                            onPressed: () async {
                              if (cubit.formKey.currentState!.validate()) {
                                await cubit.signUp(
                                  SignUpParameters(
                                    email: cubit.email.text,
                                    password: cubit.password.text,
                                    userName: cubit.userName.text,
                                    phone: cubit.phone.text,
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Are you have an account, ",
                                style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign in",
                                    style: const TextStyle(
                                      color: AppColors.darkPurple,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            FadeTransitionAnimation(
                                                page: const LoginScreen()));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
