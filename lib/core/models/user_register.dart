import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  String fullName;
  String email;
  String password;
  String phoneNumber;

  UserRegister(
      {required this.fullName, required this.email, required this.password, required this.phoneNumber});

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
      fullName: json["fullName"],
      email: json["email"],
      password: json["password"],
      phoneNumber: json["phoneNumber"]);

  Map<String, dynamic> toJson() =>
      {"fullName": fullName, "email": email, "password": password, "phoneNumber": phoneNumber};
}
