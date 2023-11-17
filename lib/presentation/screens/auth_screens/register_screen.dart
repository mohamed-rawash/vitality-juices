import 'package:drinks_app/core/utils/colors.dart';
import 'package:drinks_app/core/utils/extentsions.dart';
import 'package:drinks_app/domain/usecase/sign_up_usecase.dart';
import 'package:drinks_app/presentation/components/custom_auth_background.dart';
import 'package:drinks_app/presentation/controller/auth/auth_cubit.dart';
import 'package:drinks_app/presentation/controller/auth/auth_state.dart';
import 'package:drinks_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/global/route_transition.dart';
import '../../../core/services/services_locator.dart';
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
        if(state is SignUpSuccessfulState ) {
          print("gggggggggggggggggggggggggggggggggggggggg");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),),);
        }
        if(state is SignUpErrorState) {
          print("Register Screen Message${"*-* " * 15}" );
          print(state.errorMessage);
          print("*-* " * 15 );
        }
      },
      builder: (context, state) {
        AuthCubit _cubit = AuthCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              const CustomAuthBackground(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _cubit.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppLogo(),
                          const Text(
                            "Register Now",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              color: AppColors.green,
                            ),
                          ),
                          const Text(
                            "Enter your personal information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomAuthTextField(
                            title: "User Name",
                            controller: _cubit.userName,
                          ),
                          CustomAuthTextField(
                            title: "Email",
                            controller: _cubit.email,
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
                            controller: _cubit.phone,
                          ),
                          CustomAuthTextField(
                            title: "Password",
                            controller: _cubit.password,
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
                              if(_cubit.formKey.currentState!.validate()) {
                                await _cubit.signUp(
                                  SignUpParameters(
                                    email: _cubit.email.text,
                                    password: _cubit.password.text,
                                    userName: _cubit.userName.text,
                                    phone: _cubit.phone.text,
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
                              textScaleFactor: 1.2,
                              text: TextSpan(
                                text: "Are you have an account, ",
                                children: [
                                  TextSpan(
                                    text: "Sign in",
                                    style: const TextStyle(
                                      color: AppColors.green,
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
