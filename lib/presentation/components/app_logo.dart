import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/jsons/logo.json',
        fit: BoxFit.cover,
        width: 150,
        repeat: true,
      ),
    );
  }
}