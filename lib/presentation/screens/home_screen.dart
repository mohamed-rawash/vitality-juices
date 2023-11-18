import 'package:drinks_app/presentation/components/auth_button.dart';
import 'package:drinks_app/presentation/controller/auth/auth_cubit.dart';
import 'package:drinks_app/presentation/controller/auth/auth_state.dart';
import 'package:drinks_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/global/route_transition.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          key: AuthCubit.get(context).scaffoldKey,
          body: SafeArea(
            child: Center(
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) => {
                  if (state is SignOutSuccessfulState)
                    {
                      Navigator.pushReplacement(context,
                          FadeTransitionAnimation(page: const LoginScreen()))
                    }
                },
                builder: (context, state) {
                  return state is SignUpLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            AuthButton(
                              text: "log out",
                              onPressed: () async {
                                await AuthCubit.get(context).signOut();
                              },
                            ),
                            Text(
                                "${state is SignUpSuccessfulState ? state.userAuthModel.userName : "name"}")
                          ],
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
