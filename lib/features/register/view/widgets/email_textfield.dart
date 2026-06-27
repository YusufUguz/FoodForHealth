import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';
import 'package:food_for_health/core/general_widgets/general__tf_validations.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validateInput(value ?? "", "email"),
      decoration: InputDecoration(
        hintText: "E-mail Adresiniz",
        prefixIcon: Icon(
          FontAwesomeIcons.solidEnvelope,
          color: AppColors.appsMainColor,
        ),
        border: ConstantBorders.textFieldBorder,
        enabledBorder: ConstantBorders.textFieldBorder,
        focusedBorder: ConstantBorders.textFieldBorder,
      ),
    );
  }
}
