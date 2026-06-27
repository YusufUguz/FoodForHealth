import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';
import 'package:food_for_health/core/general_widgets/general__tf_validations.dart';

class NameSurnameTextField extends StatelessWidget {
  const NameSurnameTextField({
    super.key,
    required this.nameSurnameController,
  });

  final TextEditingController nameSurnameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameSurnameController,
      keyboardType: TextInputType.text,
      validator: (value) => validateInput(value ?? "", "namesurname"),
      decoration: InputDecoration(
        hintText: "Adınız Soyadınız",
        prefixIcon: Icon(
          FontAwesomeIcons.solidUser,
          color: AppColors.appsMainColor,
        ),
        border: ConstantBorders.textFieldBorder,
        enabledBorder: ConstantBorders.textFieldBorder,
        focusedBorder: ConstantBorders.textFieldBorder,
      ),
    );
  }
}
