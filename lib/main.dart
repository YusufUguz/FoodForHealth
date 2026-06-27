import 'package:flutter/material.dart';
import 'package:food_for_health/features/splash/splash_view.dart';

void main() {
  runApp(const FoodForHealth());
}

class FoodForHealth extends StatelessWidget {
  const FoodForHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food For Health',
      debugShowCheckedModeBanner: false,
      home: SplashView(), //Splash Screen ile uygulama başlatılır.
    );
  }
}
