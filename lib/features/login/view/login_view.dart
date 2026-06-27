import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/general__tf_validations.dart';
import 'package:food_for_health/core/general_widgets/password_textfield.dart';
import 'package:food_for_health/core/general_widgets/phone_number_textfield.dart';
import 'package:food_for_health/features/login/view/widgets/login_button.dart';
import 'package:food_for_health/features/login/view/widgets/login_register_navigating_area.dart';
import 'package:food_for_health/features/login/view/widgets/login_welcoming.dart';
import 'package:food_for_health/features/login/view_model/login_view_mixin.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              //ekranın arka planında kullanılacak resim bu şekilde verilir.
              image: DecorationImage(image: AssetImage("assets/backgrounds/bg3.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  //Textfieldların validationlarının kontrolü için FORM widgeti kullanılır.
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Giriş Sayfası Widgetlari
                        LoginWelcoming(),
                        SizedBox(height: 10),
                        PhoneNumberTextField(phoneNumberController: phoneNumberController),
                        PasswordTextField(
                          passwordController: passwordController,
                          validator: (value) => validateInput(value ?? "", "password"),
                        ),
                        ValueListenableBuilder(
                            valueListenable: isLoginButtonActive,
                            builder: (context, isLoginButtonActiveValue, child) {
                              return LoginButton(
                                isLoginButtonActiveValue: isLoginButtonActiveValue,
                                onPressed: () => loginButtonOnPressed(),
                              );
                            }),
                        SizedBox(height: 20),
                        LoginRegisterNavigatingArea()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
