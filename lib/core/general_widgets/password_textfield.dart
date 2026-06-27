import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatelessWidget {
  PasswordTextField(
      {super.key, required this.passwordController, this.isAgain = false, required this.validator});

  final TextEditingController passwordController;
  bool isAgain;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: validator,
      decoration: InputDecoration(
        hintText: isAgain ? "Şifreniz Tekrar" : "Şifreniz",
        prefixIcon: Icon(
          FontAwesomeIcons.lock,
          color: AppColors.appsMainColor,
        ),
        border: ConstantBorders.textFieldBorder,
        enabledBorder: ConstantBorders.textFieldBorder,
        focusedBorder: ConstantBorders.textFieldBorder,
      ),
    );
  }
}
