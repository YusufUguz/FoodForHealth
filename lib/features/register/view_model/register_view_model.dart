import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/user_register.dart';
import 'package:food_for_health/core/services/api_service.dart';
import 'package:http/http.dart' as http;

class RegisterViewModel {
  Future<http.Response> register(UserRegister userRegister) async {
    return ApiService.instance.post(ApiConstants.register, {
      "fullName": userRegister.fullName,
      "email": userRegister.email,
      "password": userRegister.password,
      "phoneNumber": userRegister.phoneNumber,
    });
  }
}
