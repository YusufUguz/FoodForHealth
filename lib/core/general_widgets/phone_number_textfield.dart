import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/constant_borders.dart';
import 'package:food_for_health/core/general_widgets/general__tf_validations.dart';

// ignore: must_be_immutable
class PhoneNumberTextField extends StatelessWidget {
  PhoneNumberTextField({
    super.key,
    required this.phoneNumberController,
  });

  TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: (value) => validateInput(value ?? "", "phone"),
      decoration: InputDecoration(
        hintText: "Telefon Numaranız",
        prefixIcon: Icon(
          FontAwesomeIcons.phone,
          color: AppColors.appsMainColor,
        ),
        border: ConstantBorders.textFieldBorder,
        enabledBorder: ConstantBorders.textFieldBorder,
        focusedBorder: ConstantBorders.textFieldBorder,
      ),
    );
  }
}
