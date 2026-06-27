import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/models/food.dart';
import 'package:food_for_health/core/models/user_diseases.dart';
import 'package:food_for_health/core/services/api_service.dart';
import 'package:food_for_health/features/food_evaluation/view_model/food_evaluation_state.dart';

class FoodEvaluationViewModel extends Cubit<FoodEvaluationState> {
  FoodEvaluationViewModel(this.context) : super(FoodEvaluationInitialState());
  BuildContext context;

  Future<void> getFoodByBarcode(String? barcode) async {
    emit(FoodEvaluationLoadingState());

    try {
      final response =
          await ApiService.instance.get("${ApiConstants.getfoodbybarcode}?barcode=$barcode");
      if (response.statusCode == 200) {
        emit(FoodEvaluationLoadedState(food: Food.fromJson(jsonDecode(response.body))));
      } else {
        emit(FoodEvaluationErrorState(errorMessage: "İstek başarısız : ${response.statusCode}"));
      }
    } on TimeoutException {
      emit(FoodEvaluationErrorState(errorMessage: "İstek zaman aşımına uğradı,tekrar deneyiniz."));
    } catch (e) {
      emit(FoodEvaluationErrorState(
          errorMessage: "getFoodByBarcode isteği atılırken bir sorun oluştu : ${e.toString()}"));
    }
  }

  Future<List<UserDisease>> getUserDiseases(int userID) async {
    try {
      final response = await ApiService.instance.get("${ApiConstants.getuserdiseases}?userID=$userID");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((e) => UserDisease.fromJson(e)).toList();
      } else if (response.statusCode == 404 &&
          response.body == "Kullanıcıya ait hastalık verisi bulunmamaktadır.") {
        return [];
      } else {
        throw Exception("İstek başarısız : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Kullanıcı hastalıkları çekilirken hata oluştu : ${e.toString()}");
    }
  }
}
