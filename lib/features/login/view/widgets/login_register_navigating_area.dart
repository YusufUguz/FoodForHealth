import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/general_widgets/right_to_left_animation.dart';
import 'package:food_for_health/features/register/view/register_view.dart';

class LoginRegisterNavigatingArea extends StatelessWidget {
  const LoginRegisterNavigatingArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Food For Health hesabınız yok mu?",
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, RightToLeftAnimation.createRoute(RegisterView()));
              },
              child: Text(
                "Hesap Oluştur",
                style: TextStyle(fontSize: 18, color: AppColors.appsMainColor),
              ))
        ],
      ),
    );
  }
}
