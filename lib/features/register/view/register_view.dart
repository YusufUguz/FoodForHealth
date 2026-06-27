import 'package:flutter/material.dart';
import 'package:food_for_health/core/general_widgets/general__tf_validations.dart';
import 'package:food_for_health/core/general_widgets/password_textfield.dart';
import 'package:food_for_health/core/general_widgets/phone_number_textfield.dart';
import 'package:food_for_health/core/models/user_register.dart';
import 'package:food_for_health/features/register/view/widgets/back_to_login_button.dart';
import 'package:food_for_health/features/register/view/widgets/email_textfield.dart';
import 'package:food_for_health/features/register/view/widgets/name_surname_textfield.dart';
import 'package:food_for_health/features/register/view/widgets/register_button.dart';
import 'package:food_for_health/features/register/view_model/register_view_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/backgrounds/bg3.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  //Register validasyonları için FORM widget'i kullanılır.
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Register Screen Widgetları
                        Text(
                          "Food For Health Hesabı Oluştur,Sağlıklı Kal! ❤️",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        NameSurnameTextField(nameSurnameController: nameSurnameController),
                        PhoneNumberTextField(phoneNumberController: phoneNumberController),
                        EmailTextField(emailController: emailController),
                        PasswordTextField(
                          passwordController: passwordController,
                          validator: (value) => validateInput(value ?? "", "password"),
                        ),
                        PasswordTextField(
                            passwordController: passwordAgainController,
                            isAgain: true,
                            validator: (value) => isAgainValidation(value)),
                        SizedBox(height: 15),
                        //Burada değişken buton durumu için ValueNotifier ile state yönetimi yapılır.
                        ValueListenableBuilder(
                            valueListenable: registerButtonIsActive,
                            builder: (context, registerButtonIsActiveValue, child) {
                              return RegisterButton(
                                onPressed: () => registerButtonOnPressed(UserRegister(
                                    fullName: nameSurnameController.text,
                                    email: emailController.text,
                                    password: passwordAgainController.text,
                                    phoneNumber: phoneNumberController.text)),
                                registerButtonIsActiveValue: registerButtonIsActiveValue,
                              );
                            }),
                        BackToLoginButton()
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

  //Şifre tekrar için validasyon fonksiyonu
  String? isAgainValidation(value) {
    if (passwordAgainController.text == "") {
      return "Boş Bırakılamaz!";
    } else if (passwordAgainController.text != passwordController.text) {
      return "Şifreler uyuşmuyor.";
    } else {
      return null;
    }
  }
}
