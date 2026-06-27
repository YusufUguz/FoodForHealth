import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/user_info.dart';
import 'package:food_for_health/core/services/api_service.dart';
import 'package:food_for_health/features/profile/view_model/user_info_state.dart';

class UserInfoViewModel extends Cubit<UserInfoState> {
  UserInfoViewModel(this.context) : super(UserInfoInitialState());
  BuildContext context;

  Future<void> getUserInfos(int userID) async {
    emit(UserInfoLoadingState());

    try {
      final response = await ApiService.instance.get("${ApiConstants.getuserinfo}?userID=$userID");
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
    try {
      final response =
          await ApiService.instance.post(ApiConstants.createuserinfo, userInfoModel.toJson());

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
