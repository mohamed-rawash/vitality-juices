import 'package:drinks_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAuthBackground extends StatelessWidget {
  const CustomAuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.purple,
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    Offset start = Offset(size.width, size.width - 150);
    Offset end = Offset(0, size.width);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
  
}