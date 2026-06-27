import 'package:flutter/material.dart';

class RightToLeftAnimation {
  static Route createRoute(Widget otherPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => otherPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Sağdan başla
        const end = Offset.zero; // Sola kay
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
