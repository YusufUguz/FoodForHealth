import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoginButtonActiveValue,
  });

  void Function()? onPressed;
  bool isLoginButtonActiveValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.appsMainColor,
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoginButtonActiveValue
            ? const Text(
                "Giriş Yap",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
