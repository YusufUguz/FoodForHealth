import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/user_info.dart';
import 'package:food_for_health/features/profile/view_model/user_info_state.dart';
import 'package:http/http.dart' as http;

class UserInfoViewModel extends Cubit<UserInfoState> {
  UserInfoViewModel(this.context) : super(UserInfoInitialState());
  BuildContext context;

  Future<void> getUserInfos(int userID) async {
    emit(UserInfoLoadingState());
    final apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.getuserinfo}?userID=$userID");

    try {
      final response = await http.get(apiURL).timeout(Duration(minutes: 1));
      if (response.statusCode == 200) {
        emit(UserInfoLoadedState(userInfo: UserInfo.fromJson(jsonDecode(response.body))));
      } else {
        if (response.statusCode == 404 && response.body == "Kullanıcı bilgisi bulunamadı.") {
          emit(UserInfoErrorState(errorMessage: "Kullanıcı bilgisi bulunamadı."));
        } else {
          emit(UserInfoErrorState(errorMessage: "İstek başarısız : ${response.statusCode}"));
        }
      }
    } on TimeoutException {
      emit(UserInfoErrorState(errorMessage: "İstek zaman aşımına uğradı,tekrar deneyiniz."));
    } catch (e) {
      emit(UserInfoErrorState(errorMessage: "İstek gönderilirken bir sorun oluştu,tekrar deneyiniz."));
    }
  }

  Future<bool> createUserInfo(UserInfo userInfoModel) async {
    final apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.createuserinfo}");

    try {
      final response = await http.post(
        apiURL,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userInfoModel.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        debugPrint("istek Başarısız : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Kullanıcı bilgisi oluşturulurken hata oluştu : ${e.toString()}");
      return false;
    }
  }
}
