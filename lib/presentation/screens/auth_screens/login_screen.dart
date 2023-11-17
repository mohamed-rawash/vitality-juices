import 'package:drinks_app/domain/usecase/sign_in_usecase.dart';
import 'package:drinks_app/presentation/components/custom_auth_background.dart';
import 'package:drinks_app/presentation/controller/auth/auth_cubit.dart';
import 'package:drinks_app/presentation/controller/auth/auth_state.dart';
import 'package:drinks_app/presentation/screens/auth_screens/register_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/global/route_transition.dart';
import '../../../core/utils/colors.dart';
import '../../components/app_logo.dart';
import '../../components/auth_button.dart';
import '../../components/custom_auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is SignInSuccessfulState) {
          Navigator.pushReplacement(context, FadeTransitionAnimation(page: const HomeScreen()));
        }
        if(state is SignInErrorState) {
          print("Login Screen Message${"*-* " * 15}" );
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLogo(),
                        const Text(
                          "Sign In",
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        CustomAuthTextField(
                          title: "Email",
                          controller: _cubit.email,
                        ),
                        CustomAuthTextField(
                          title: "Password",
                          controller: _cubit.password,
                          show: true,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        AuthButton(
                          text: "Sign In",
                          onPressed: () async {
                            await _cubit.signIn(SignInParameters(email: _cubit.email.text, password: _cubit.password.text));
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                color: AppColors.green,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR",
                                style: TextStyle(color: AppColors.yellow),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AuthIconButton(
                                icon: Image.asset(
                                    "assets/images/google_icon.png"),
                                tooltip: "Google",
                                color: AppColors.grey,
                                onPressed: () {}),
                            AuthIconButton(
                                icon: const Icon(FontAwesomeIcons.facebook),
                                tooltip: "Facebook",
                                color: Colors.blueAccent,
                                onPressed: () {}),
                            AuthIconButton(
                                icon: const Icon(FontAwesomeIcons.twitter),
                                tooltip: "Twitter",
                                color: Colors.lightBlueAccent,
                                onPressed: () {}),
                            AuthIconButton(
                                icon: const Icon(FontAwesomeIcons.github),
                                tooltip: "Github",
                                color: Colors.black38,
                                onPressed: () {}),
                          ],
                        ),
                        Center(
                          child: RichText(
                            textScaleFactor: 1.2,
                            text: TextSpan(
                              text: "You have not an account, ",
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                    color: AppColors.green,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                          context,
                                          FadeTransitionAnimation(
                                              page: const RegisterScreen()));
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
            ],
          ),
        );
      },
    );
  }
}

class AuthIconButton extends StatelessWidget {
  const AuthIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.color,
      required this.tooltip});

  final Widget icon;
  final Color color;
  final String tooltip;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 40,
      padding: EdgeInsets.zero,
      color: Colors.white,
      icon: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        child: Center(
          child: icon,
        ),
      ),
      tooltip: tooltip,
    );
  }
}
