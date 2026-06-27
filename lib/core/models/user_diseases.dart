import 'dart:convert';

UserDisease userDiseasesFromJson(String str) => UserDisease.fromJson(json.decode(str));

String userDiseasesToJson(UserDisease data) => json.encode(data.toJson());

class UserDisease {
  int id;
  int userID;
  int diseaseID;
  String diseaseName;
  String notes;
  DateTime startDate;
  DateTime dateAdded;

  UserDisease({
    required this.id,
    required this.userID,
    required this.diseaseID,
    required this.diseaseName,
    required this.notes,
    required this.startDate,
    required this.dateAdded,
  });

  factory UserDisease.fromJson(Map<String, dynamic> json) => UserDisease(
        id: json["id"],
        userID: json["userID"],
        diseaseID: json["diseaseID"],
        diseaseName: json["diseaseName"],
        notes: json["notes"],
        startDate: DateTime.parse(json["startDate"]),
        dateAdded: DateTime.parse(json["dateAdded"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userID,
        "diseaseID": diseaseID,
        "diseaseName": diseaseName,
        "notes": notes,
        "startDate": startDate.toIso8601String(),
        "dateAdded": dateAdded.toIso8601String(),
      };
}
