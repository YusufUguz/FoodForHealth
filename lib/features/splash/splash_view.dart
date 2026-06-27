import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/features/splash/splash_mixin.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("FOOD FOR HEALTH", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const CircularProgressIndicator(color: AppColors.appsMainColor)
          ],
        ),
      ),
    );
  }
}
