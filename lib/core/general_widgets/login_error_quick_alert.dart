import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

Future<dynamic> loginErrorsQuickAlert(
    BuildContext context, http.Response response, Map<String, dynamic> jsonMessage) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: "Bir Sorun Oluştu.",
    text: "Hata Kodu : ${response.statusCode}\n${jsonMessage["message"]}",
    confirmBtnText: "Kapat",
  );
}
