import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_for_health/core/models/cache_user.dart';

class SecureStorageManager {
  static final SecureStorageManager _instance = SecureStorageManager._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  factory SecureStorageManager() {
    return _instance;
  }

  SecureStorageManager._internal();

  //CACHE USER OPERATIONS

  Future<void> saveUserInfo(CacheUser userinfo) async {
    await _secureStorage.write(key: "cacheUser", value: userinfo.toJsonString());
  }

  Future<void> saveUserID(String userID) async {
    await _secureStorage.write(key: "userID", value: userID);
  }

  Future<int> getUserID() async {
    String userIDString = await _secureStorage.read(key: "userID") ?? "";
    return int.parse(userIDString);
  }

  Future<void> clearUserID() async {
    return await _secureStorage.delete(key: "userID");
  }

  Future<CacheUser> getUserInfo() async {
    String? userInfoString = await _secureStorage.read(key: "cacheUser");
    if (userInfoString == null) {
      throw Exception("Bir sorun oluştu,kullanıcı bilgisi bulunamadı.");
    } else {
      Map<String, dynamic> userInfoMap = json.decode(userInfoString);
      return CacheUser.fromJson(userInfoMap);
    }
  }

  Future<void> clearCacheUser() async {
    return await _secureStorage.delete(key: "cacheUser");
  }

  //LOGIN TOKEN OPERATIONS

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }

  Future<bool> controlToken() async {
    return await _secureStorage.read(key: "token") == null ? false : true;
  }

  Future<void> clearToken() async {
    return await _secureStorage.delete(key: "token");
  }

  // GENERAL OPERATIONS

  Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }
}
