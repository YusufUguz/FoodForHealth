import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/jwt_token_management.dart';
import 'package:food_for_health/core/general_widgets/right_to_left_animation.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/features/bottom_nav_bar/view/bottom_nav_bar_view.dart';
import 'package:food_for_health/features/login/view/login_view.dart';

mixin SplashViewMixin<SplashView extends StatefulWidget> on State<SplashView> {
  SecureStorageManager storageManager = SecureStorageManager();
  @override
  void initState() {
    super.initState();
    navigatingHomeOrLogin();
  }

  //Bu fonksiyon ile kullanıcı daha önce giriş yapmışsa ve tokeni geçerli ise splash screen'den anasayfaya yönlendirilir,giriş yapmamışsa ise Login sayfasına yönlendirilir.
  Future<void> navigatingHomeOrLogin() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (await storageManager.controlToken() && await isTokenExpired()) {
      if (mounted) {
        //Anasayfaya yönlendirir.
        Navigator.pushReplacement(context, RightToLeftAnimation.createRoute(const BottomNavBarView()));
      }
    } else {
      if (mounted) {
        //Logine yönlendirir.
        Navigator.pushReplacement(context, RightToLeftAnimation.createRoute(const LoginView()));
      }
    }
  }

  //Bu fonksiyon ile giriş tokeninin geçerli olup olmadığı kontrol edilir.
  Future<bool> isTokenExpired() async {
    String? token = await storageManager.getToken();

    bool isExpired = TokenManagement().isTokenExpired(token);

    if (isExpired) {
      return false;
    } else {
      return true;
    }
  }
}
