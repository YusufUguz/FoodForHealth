import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/disease.dart';
import 'package:food_for_health/core/models/user_diseases.dart';
import 'package:food_for_health/core/services/api_service.dart';
import 'package:food_for_health/features/profile/view_model/user_diseases_state.dart';

class UserDiseasesViewModel extends Cubit<UserDiseasesState> {
  UserDiseasesViewModel(this.context) : super(UserDiseasesInitialState());
  BuildContext context;

  Future<List<Disease>> getDiseases() async {
    try {
      final response = await ApiService.instance.get(ApiConstants.getdiseases);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Disease> diseases = jsonResponse.map((disease) => Disease.fromJson(disease)).toList();
        return diseases;
      } else {
        throw Exception("İstek başarısız : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Hastalıklar alınırken bir sorun oluştu.");
    }
  }

  Future<void> getUserDiseases(int userID) async {
    emit(UserDiseasesLoadingState());

    try {
      final response = await ApiService.instance.get("${ApiConstants.getuserdiseases}?userID=$userID");
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<UserDisease> diseases = jsonResponse.map((disease) => UserDisease.fromJson(disease)).toList();
        emit(UserDiseasesLoadedState(userDiseases: diseases));
      } else {
        if (response.statusCode == 404 &&
            response.body == "Kullanıcıya ait hastalık verisi bulunmamaktadır.") {
          emit(UserDiseasesErrorState(errorMessage: "Kullanıcıya ait hastalık verisi bulunamadı."));
        } else {
          emit(UserDiseasesErrorState(errorMessage: "İstek başarısız : ${response.statusCode}"));
        }
      }
    } on TimeoutException {
      emit(UserDiseasesErrorState(errorMessage: "İstek zaman aşımına uğradı,tekrar deneyiniz."));
    } catch (e) {
      emit(UserDiseasesErrorState(errorMessage: "İstek gönderilirken bir sorun oluştu,tekrar deneyiniz."));
    }
  }

  Future<bool> createUserDisease(UserDisease userDisease) async {
    try {
      final response =
          await ApiService.instance.post(ApiConstants.createuserdisease, userDisease.toJson());

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        debugPrint("İstek başarısız : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("İstek atılırken bir sorun oluştu : ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteUserDisease(int id) async {
    try {
      final response = await ApiService.instance.delete("${ApiConstants.deleteuserdisease}?ID=$id");

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint("İstek başarısız : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("İstek atılırken bir sorun oluştu : ${e.toString()}");
      return false;
    }
  }
}
