import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/general_widgets/login_error_quick_alert.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/core/models/cache_user.dart';
import 'package:http/http.dart' as http;

class LoginViewModel {
  final storage = const FlutterSecureStorage();
  SecureStorageManager secureStorageManager = SecureStorageManager();

  //API'a yapılan login isteği
  Future<bool> login(String phoneNumber, String password, BuildContext context) async {
    final url = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.login}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phoneNumber": phoneNumber,
        "password": password,
      }),
    );
    //Login başarılı ise bu işlemler gerçekleşir.
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      //Login başarılı olduğunda kullanıcı bilgileri cache'e kaydedilir.Bilgileri gerektiğinde buradan çekilerek kullanılır.
      CacheUser cacheUser = CacheUser(
          token: data["token"],
          userID: data["userID"],
          fullName: data["fullName"],
          phoneNumber: data["phoneNumber"],
          email: data["email"]);

      String userID = cacheUser.userID.toString();
      String token = cacheUser.token;

      await secureStorageManager.saveUserID(userID);
      await secureStorageManager.saveUserInfo(cacheUser);
      await secureStorageManager.saveToken(token);
      return true;
    } else {
      //Login başarılı değilse bu işlemler gerçekleşir.
      if (response.body.isNotEmpty) {
        //Başarısız olan login'in hata mesajları kullanıcıya alert dialog ile gösterilir.
        Map<String, dynamic> jsonMessage = jsonDecode(response.body);
        if (jsonMessage["message"] == null && response.statusCode != 200) {
          jsonMessage["message"] = "Bir Sorun Oluştu";
          if (context.mounted) {
            loginErrorsQuickAlert(context, response, jsonMessage);
          }
        } else {
          if (context.mounted) {
            loginErrorsQuickAlert(context, response, jsonMessage);
          }
        }
      }
      return false;
    }
  }
}
