import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';

// ignore: must_be_immutable
class ProfileBaseInfoRows extends StatelessWidget {
  ProfileBaseInfoRows({
    super.key,
    required this.icon,
    required this.infoText,
  });

  String infoText;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(
          icon,
          size: 15,
          color: AppColors.appsMainColor,
        ),
        Text(infoText, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
