import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/right_to_left_animation.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/features/login/view/login_view.dart';

class GeneralButtonOnpresseds {
  void signOutButtonOnPressed(BuildContext context) async {
    await SecureStorageManager().clearToken();
    await SecureStorageManager().clearCacheUser();
    await SecureStorageManager().clearUserID();
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.push(context, RightToLeftAnimation.createRoute(const LoginView()));
    }
  }
}
