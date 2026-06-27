import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  int id;
  int userID;
  String nameSurname;
  int height;
  int weight;
  String gender;
  DateTime birthDate;

  UserInfo({
    required this.id,
    required this.userID,
    required this.nameSurname,
    required this.height,
    required this.weight,
    required this.gender,
    required this.birthDate,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        userID: json["userID"],
        nameSurname: json["nameSurname"],
        height: json["height"],
        weight: json["weight"],
        gender: json["gender"],
        birthDate: DateTime.parse(json["birthDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userID,
        "nameSurname": nameSurname,
        "height": height,
        "weight": weight,
        "gender": gender,
        "birthDate": birthDate.toIso8601String(),
      };
}
