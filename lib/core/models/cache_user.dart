import 'dart:convert';

CacheUser cacheUserFromJson(String str) => CacheUser.fromJson(json.decode(str));

String cacheUserToJson(CacheUser data) => json.encode(data.toJson());

class CacheUser {
  String token;
  int userID;
  String fullName;
  String email;
  String phoneNumber;

  CacheUser(
      {required this.token,
      required this.userID,
      required this.fullName,
      required this.email,
      required this.phoneNumber});

  factory CacheUser.fromJson(Map<String, dynamic> json) => CacheUser(
      token: json["token"],
      userID: json["userID"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"]);

  Map<String, dynamic> toJson() =>
      {"token": token, "userID": userID, "fullName": fullName, "email": email, "phoneNumber": phoneNumber};

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
