import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/ai_prompts.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:food_for_health/features/food_evaluation/view/widgets/food_info_card.dart';
import 'package:food_for_health/features/food_evaluation/view/widgets/food_evaluation_card.dart';
import 'package:food_for_health/features/food_evaluation/view/widgets/is_good_or_not_info_card.dart';
import 'package:food_for_health/features/food_evaluation/view_model/food_evaluation_state.dart';
import 'package:food_for_health/features/food_evaluation/view_model/food_evaluation_view_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class FoodEvaluationView extends StatefulWidget {
  FoodEvaluationView({super.key, required this.barcode});

  Barcode barcode;

  @override
  State<FoodEvaluationView> createState() => _FoodEvaluationViewState();
}

class _FoodEvaluationViewState extends State<FoodEvaluationView> {
  late FoodEvaluationViewModel foodEvaluationViewModel;
  SecureStorageManager ssm = SecureStorageManager();
  List<String> userDiseases = [];

  @override
  void initState() {
    super.initState();
    foodEvaluationViewModel = FoodEvaluationViewModel(context);
    foodEvaluationViewModel.getFoodByBarcode(widget.barcode.code);
    getUserID().then((value) {
      loadUserDiseases(value);
    });
  }

  Future<String> getAIReponse(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: ApiConstants.geminiAPIKey,
    );

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    return response.text!;
  }

  Future<int> getUserID() async {
    return ssm.getUserID();
  }

  Future<void> loadUserDiseases(int userID) async {
    try {
      final diseases = await foodEvaluationViewModel.getUserDiseases(userID);
      if (diseases == []) {
        userDiseases = [];
      }
      userDiseases = diseases.map((disease) => disease.diseaseName).toList();

      setState(() {});
    } catch (e) {
      debugPrint('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Kullanıcı hastalıkları : ${userDiseases.toString()}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yiyecek Değerlendirmesi",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17)),
          centerTitle: true,
          backgroundColor: AppColors.appsMainColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              )),
        ),
        body: BlocProvider(
          create: (context) => foodEvaluationViewModel,
          child: BlocBuilder<FoodEvaluationViewModel, FoodEvaluationState>(
            builder: (context, state) {
              if (state is FoodEvaluationLoadingState) {
                return Center(child: CircularProgressIndicator(color: AppColors.appsMainColor));
              } else if (state is FoodEvaluationErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is FoodEvaluationLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      IsGoodOrNotInfoCard(
                          futureFunction: getAIReponse(AiPrompts.isFoodGoodOrNotForUser(
                              state.food.ings, userDiseases.toString(), state.food.foodName))),
                      FoodInfoCard(stateFood: state.food),
                      FoodEvaluationCard(
                        futureFunction: getAIReponse(AiPrompts.foodEvaluation(
                            state.food.ings, userDiseases.toString(), state.food.foodName)),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
