import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PersonalInfosSingleCard extends StatelessWidget {
  PersonalInfosSingleCard({super.key, required this.cardText, required this.iconPath});

  String iconPath;
  String cardText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          Text(cardText,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
