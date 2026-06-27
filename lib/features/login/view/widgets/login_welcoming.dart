import 'package:flutter/material.dart';

class LoginWelcoming extends StatelessWidget {
  const LoginWelcoming({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Merhaba 👋",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        Text(
          "Food For Health Hesabına Giriş Yap!",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
