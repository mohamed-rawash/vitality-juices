import 'package:drinks_app/core/utils/cache_helper.dart';
import 'package:drinks_app/presentation/screens/auth_screens/register_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:drinks_app/presentation/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/global/route_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );

  @override
  void initState() {
    var isNotBoard = CacheHelper.getData(key: "onBoarding") ?? false;

    Future.delayed(
      const Duration(seconds: 5),
      () => !isNotBoard
          ? Navigator.pushReplacement(
              context, FadeTransitionAnimation(page: const OnboardingScreen()))
          : FirebaseAuth.instance.currentUser != null
              ? Navigator.pushReplacement(
                  context, FadeTransitionAnimation(page: const HomeScreen()))
              : Navigator.pushReplacement(context,
                  FadeTransitionAnimation(page: const RegisterScreen())),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Lottie.asset(
            'assets/jsons/logo.json',
            repeat: true,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
