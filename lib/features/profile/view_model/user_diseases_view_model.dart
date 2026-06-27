import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/disease.dart';
import 'package:food_for_health/core/models/user_diseases.dart';
import 'package:food_for_health/features/profile/view_model/user_diseases_state.dart';
import 'package:http/http.dart' as http;

class UserDiseasesViewModel extends Cubit<UserDiseasesState> {
  UserDiseasesViewModel(this.context) : super(UserDiseasesInitialState());
  BuildContext context;

  Future<List<Disease>> getDiseases() async {
    final apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.getdiseases}");

    try {
      final response = await http.get(apiURL);

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
    final apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.getuserdiseases}?userID=$userID");

    try {
      final response = await http.get(apiURL).timeout(Duration(minutes: 1));
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
    var apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.createuserdisease}");

    try {
      final response = await http.post(apiURL,
          headers: {"Content-Type": "application/json"}, body: jsonEncode((userDisease.toJson())));

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
    var apiURL = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.deleteuserdisease}?ID=$id");

    try {
      final response = await http.delete(
        apiURL,
      );

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
