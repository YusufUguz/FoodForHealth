import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';

class ConstantBorders {
  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 2, color: AppColors.appsMainColor));
  static OutlineInputBorder mbsTextFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: 2, color: AppColors.appsMainColor));
}
