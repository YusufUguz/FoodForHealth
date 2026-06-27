import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/right_to_left_animation.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/features/bottom_nav_bar/view/bottom_nav_bar_view.dart';
import 'package:food_for_health/features/login/view/login_view.dart';
import 'package:food_for_health/features/login/view_model/login_view_model.dart';
import 'package:quickalert/quickalert.dart';

mixin LoginViewMixin on State<LoginView> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoginButtonActive = ValueNotifier(true);

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //Login butonuna basıldığında bu işlemler gerçekleşir.
  void loginButtonOnPressed() async {
    if (formKey.currentState!.validate()) {
      //Textfield Validasyonlarında sorun yok ise bu işlemler gerçekleştirilir.
      FocusScope.of(context).unfocus();
      isLoginButtonActive.value = false;

      try {
        //API'a login isteği atılır.
        bool loginSuccessful = await LoginViewModel()
            .login(phoneNumberController.text, passwordController.text, context)
            .timeout(const Duration(seconds: 60));

        if (loginSuccessful) {
          bool isTokenAvailable = await SecureStorageManager().controlToken();
          //Giriş başarılı ve token geçerli ise anasayfaya yönlendirilir.
          if (isTokenAvailable && mounted) {
            Navigator.pushAndRemoveUntil(
                context, RightToLeftAnimation.createRoute(const BottomNavBarView()), (route) => false);
          } else {}
        } else {
          isLoginButtonActive.value = true;
        }
      } on TimeoutException {
        //Login isteğinde zaman aşımı olursa bu alert dialog gösterilir.
        isLoginButtonActive.value = true;
        if (mounted) {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Zaman aşımına uğradı.",
              text: "Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz.",
              confirmBtnText: "Tamam",
              showConfirmBtn: true,
              showCancelBtn: false,
              onConfirmBtnTap: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        isLoginButtonActive.value = true;
        if (mounted) {
          //Başka sorunlar için bu alert dialog gösterilir.
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Bir Hata oluştu.",
              text: "Beklenmeyen bir hata oluştu,internet bağlantınızı kontrol ediniz.",
              confirmBtnText: "Tamam",
              showConfirmBtn: true,
              showCancelBtn: false,
              onConfirmBtnTap: () {
                Navigator.pop(context);
              });
        }
      }
    }
  }
}
