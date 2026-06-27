import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IsGoodOrNotInfoCard extends StatelessWidget {
  IsGoodOrNotInfoCard({super.key, required this.futureFunction});

  Future<Object?>? futureFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future: futureFunction,
              builder: (context, snapshot) {
                String aiResponseInFuture = snapshot.data.toString();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      "Uygunluk değerlendirmesi yapılıyor...",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        aiResponseInFuture,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      aiResponseInFuture.contains("uygundur")
                          ? Image.asset(
                              "assets/icons/good.png",
                              width: 45,
                              height: 45,
                            )
                          : Image.asset(
                              "assets/icons/bad.png",
                              width: 45,
                              height: 45,
                            )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
