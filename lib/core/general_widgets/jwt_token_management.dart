import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManagement {
  // Token'in süresi dolmuş mu kontrol etmek için bir fonksiyon
  bool isTokenExpired(String? token) {
    // Süresinin dolup dolmadığını kontrol ediyoruz
    return JwtDecoder.isExpired(token!);
  }

// Token'in ne zaman süresinin dolacağını öğrenmek için
  DateTime getTokenExpirationDate(String? token) {
    // Expiration tarihi döndürülüyor
    return JwtDecoder.getExpirationDate(token!);
  }

// Token'in kalan süresini öğrenmek için
  Duration getTokenRemainingTime(String token) {
    return JwtDecoder.getRemainingTime(token);
  }
}
