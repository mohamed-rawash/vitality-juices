import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}