import 'package:flutter/material.dart';
import 'package:food_for_health/features/food_evaluation/view/widgets/adjust_ai_response.dart';

// ignore: must_be_immutable
class FoodEvaluationCard extends StatelessWidget {
  FoodEvaluationCard({
    super.key,
    required this.futureFunction,
  });

  Future<Object?>? futureFunction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: FutureBuilder(
                  future: futureFunction,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "Yiyecek değerlendirmesi yapılıyor...",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Yiyecek Değerlendirmesi",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            AdjustAIResponse(
                              text: snapshot.data.toString(),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
