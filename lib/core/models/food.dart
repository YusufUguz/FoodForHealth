import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  int id;
  String foodName;
  String foodDescription;
  String categoryName;
  String ings;
  DateTime expireDate;
  String allergenInfo;
  int calorie;
  String barcode;

  Food({
    required this.id,
    required this.foodName,
    required this.foodDescription,
    required this.categoryName,
    required this.ings,
    required this.expireDate,
    required this.allergenInfo,
    required this.calorie,
    required this.barcode,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        foodName: json["foodName"],
        foodDescription: json["foodDescription"],
        categoryName: json["categoryName"],
        ings: json["ings"],
        expireDate: DateTime.parse(json["expireDate"]),
        allergenInfo: json["allergenInfo"],
        calorie: json["calorie"],
        barcode: json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foodName": foodName,
        "foodDescription": foodDescription,
        "categoryName": categoryName,
        "ings": ings,
        "expireDate": expireDate.toIso8601String(),
        "allergenInfo": allergenInfo,
        "calorie": calorie,
        "barcode": barcode,
      };
}
