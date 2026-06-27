import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/check_http_status_code.dart';
import 'package:food_for_health/core/general_widgets/right_to_left_animation.dart';
import 'package:food_for_health/core/models/user_register.dart';
import 'package:food_for_health/features/login/view/login_view.dart';
import 'package:food_for_health/features/register/view_model/register_view_model.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';

mixin RegisterViewMixin<RegisterView extends StatefulWidget> on State<RegisterView> {
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> registerButtonIsActive = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameSurnameController.dispose();
    super.dispose();
  }
  //Kayıt Ol butonuna basıldığında bu işlemler gerçekleşir.
  Future<void> registerButtonOnPressed(UserRegister userRegister) async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      registerButtonIsActive.value = false;
      try {
        //API'a register isteği yapılır.
        Response registerResponse =
            await RegisterViewModel().register(userRegister).timeout(const Duration(seconds: 60));
        if (mounted) {
          registerQuickAlerts(registerResponse);
        }
      } on TimeoutException {
        registerButtonIsActive.value = true;
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
        registerButtonIsActive.value = true;
        if (mounted) {
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

  Future<dynamic> registerQuickAlerts(Response registerResponse) {
    registerButtonIsActive.value = true;
    if (registerResponse.statusCode == 201 ||
        registerResponse.statusCode == 200 && checkHttpStatusCode(registerResponse).isError == false) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Kayıt Başarılı!",
        text: checkHttpStatusCode(registerResponse).codeMessage,
        confirmBtnText: "Giriş Sayfasına Git",
        onConfirmBtnTap: () {
          Navigator.pushAndRemoveUntil(
              context, RightToLeftAnimation.createRoute(const LoginView()), (route) => false);
        },
      );
    } else {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Bir Sorun Oluştu",
        text: checkHttpStatusCode(registerResponse).codeMessage,
        confirmBtnText: "Kapat",
        onConfirmBtnTap: () => Navigator.pop(context),
      );
    }
  }
}
