import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/user_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterViewModel {
  Future<http.Response> register(UserRegister userRegister) async {
    const String url = '${ApiConstants.apiBaseUrl}${ApiConstants.register}';

    final Map<String, dynamic> requestBody = {
      "fullName": userRegister.fullName,
      "email": userRegister.email,
      "password": userRegister.password,
      "phoneNumber": userRegister.phoneNumber
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      return http.Response(response.body, response.statusCode);
    }
  }
}
