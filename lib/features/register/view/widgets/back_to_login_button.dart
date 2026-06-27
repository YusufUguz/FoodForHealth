import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Giriş Ekranına Dön",
            style: TextStyle(fontSize: 18, color: AppColors.appsMainColor),
          )),
    );
  }
}
