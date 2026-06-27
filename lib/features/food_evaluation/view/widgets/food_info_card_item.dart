import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FoodInfoCardItem extends StatelessWidget {
  FoodInfoCardItem({super.key, required this.headLine, required this.text});

  String text;
  String headLine;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: headLine,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: text,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: headLine.contains("İçindekiler : ") ||
                          headLine.contains("Alerjen Bilgileri : ") ||
                          headLine.contains("Yiyecek Açıklaması : ")
                      ? 13
                      : 14)),
        ],
      ),
    );
  }
}
