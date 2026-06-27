import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/models/food.dart';
import 'package:food_for_health/features/food_evaluation/view/widgets/food_info_card_item.dart';

// ignore: must_be_immutable
class FoodInfoCard extends StatelessWidget {
  FoodInfoCard({super.key, required this.stateFood});

  Food stateFood;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.lightBlueColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Text(
                "Yiyecek Bilgileri",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              FoodInfoCardItem(headLine: "Yiyecek İsmi : ", text: stateFood.foodName),
              FoodInfoCardItem(headLine: "İçindekiler : ", text: stateFood.ings),
              FoodInfoCardItem(headLine: "Alerjen Bilgileri : ", text: stateFood.allergenInfo),
              FoodInfoCardItem(headLine: "Yiyecek Kategorisi : ", text: stateFood.categoryName),
              FoodInfoCardItem(headLine: "Yiyecek Açıklaması : ", text: stateFood.foodDescription),
              FoodInfoCardItem(
                  headLine: "Bir Adetin Kalorisi : ", text: "${stateFood.calorie.toString()} kcal"),
            ],
          ),
        ),
      ),
    );
  }
}
