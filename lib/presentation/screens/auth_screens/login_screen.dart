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
        if(state is SignInSuccessfulState || state is GoogleSignInSuccessfulState) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Welcome You Logged In Successful",
              style: TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.green,
            behavior: SnackBarBehavior.floating,
          ),);}
        if( state is SignInErrorState) {
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
        if( state is GoogleSignInErrorState) {
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLogo(),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: AppColors.darkPurple,
                          ),
                        ),
                        const Text(
                          "Enter your personal information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 2,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        CustomAuthTextField(
                          title: "Email",
                          controller: cubit.email,
                        ),
                        CustomAuthTextField(
                          title: "Password",
                          controller: cubit.password,
                          show: true,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        AuthButton(
                          text: "Sign In",
                          onPressed: () async {
                            await cubit.signIn(SignInParameters(email: cubit.email.text, password: cubit.password.text));
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "You have not an account, ",
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                      color: AppColors.darkPurple,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                color: AppColors.darkPurple,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR",
                                style: TextStyle(color: AppColors.darkPurple),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                color: AppColors.darkPurple,
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
                                onPressed: () async {
                                  await cubit.googleSignIn();
                                },),
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
//!!rfr_rm_899!!599&