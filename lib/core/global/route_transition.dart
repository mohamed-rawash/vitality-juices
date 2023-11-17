import 'package:flutter/material.dart';

class FadeTransitionAnimation extends PageRouteBuilder {
  final Widget page;
  FadeTransitionAnimation({ required this.page}):super(
    pageBuilder: (context, animation, animationTwo) => page,
    transitionsBuilder: (context, animation, animationTwo, child) {
      return FadeTransition(opacity: animation, child: child,);
    },
  );
}

class ScaleTransitionAnimation extends PageRouteBuilder {
  final Widget page;
  ScaleTransitionAnimation({ required this.page}):super(
    pageBuilder: (context, animation, animationTwo) => page,
    transitionsBuilder: (context, animation, animationTwo, child) {
      double begin = 1.0;
      double end = 0.0;
      Tween<double> tween = Tween(begin: begin, end: end);
      CurvedAnimation curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return ScaleTransition(scale: tween.animate(curvesAnimation), child: child,);
    },
  );
}