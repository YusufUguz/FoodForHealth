import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';

// ignore: must_be_immutable
class RegisterButton extends StatelessWidget {
  RegisterButton({
    super.key,
    required this.onPressed,
    required this.registerButtonIsActiveValue,
  });

  void Function()? onPressed;
  bool registerButtonIsActiveValue;

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
          child: registerButtonIsActiveValue
              ? Text(
                  "Kayıt Ol",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              : CircularProgressIndicator(
                  color: Colors.white,
                )),
    );
  }
}
