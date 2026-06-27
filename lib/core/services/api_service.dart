import 'dart:convert';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/general_widgets/secure_storage_manager.dart';
import 'package:http/http.dart' as http;

/// Tüm REST çağrıları için tek giriş noktası.
/// Base URL, JSON header'ları, JWT token ve ortak timeout'u tek yerde toplar;
/// böylece feature view-model'leri bu kurulumu tekrar tekrar yazmaz.
class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final SecureStorageManager _storage = SecureStorageManager();
  static const Duration _timeout = Duration(minutes: 1);

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<http.Response> get(String endpoint) async {
    return http.get(_uri(endpoint), headers: await _headers()).timeout(_timeout);
  }

  Future<http.Response> post(String endpoint, Object? body) async {
    return http
        .post(_uri(endpoint), headers: await _headers(), body: jsonEncode(body))
        .timeout(_timeout);
  }

  Future<http.Response> delete(String endpoint) async {
    return http.delete(_uri(endpoint), headers: await _headers()).timeout(_timeout);
  }

  Uri _uri(String endpoint) => Uri.parse("${ApiConstants.apiBaseUrl}$endpoint");
}
