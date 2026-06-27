import 'package:food_for_health/core/models/http_status_code_response.dart';
import 'package:http/http.dart';

HttpStatusCodeReponses checkHttpStatusCode(Response registerResponse) {
  if (registerResponse.statusCode == 200) {
    return HttpStatusCodeReponses(
        isError: false, statusCode: registerResponse.statusCode, codeMessage: "İstek Başarıyla tamamlandı.");
  } else if (registerResponse.statusCode == 201) {
    return HttpStatusCodeReponses(
        isError: false,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hesabınız Başarıyla Oluşturuldu.");
  } else if (registerResponse.statusCode == 400 && registerResponse.body.contains("DuplicateEmail")) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage:
            "Hata Kodu : ${registerResponse.statusCode}\n\nAynı E-Mail ile oluşturulmuş bir hesap bulunmaktadır.Lütfen başka bir mail adresi deneyiniz.");
  } else if (registerResponse.statusCode == 400 && registerResponse.body.contains("DuplicatePhoneNumber")) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage:
            "Hata Kodu : ${registerResponse.statusCode}\n\nBu telefon numarasıyla oluşturulmuş bir hesap bulunmaktadır,lütfen başka bir telefon numarası giriniz.");
  }
  if (registerResponse.statusCode == 400) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage:
            "Hata Kodu : ${registerResponse.statusCode}\n\nYanlış İstek Gönderildi. ${registerResponse.body}");
  } else if (registerResponse.statusCode == 401) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nYetkisiz İşlem.");
  } else if (registerResponse.statusCode == 404) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nSunucu kaynağı bulunamadı.");
  } else if (registerResponse.statusCode == 408) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nİstek zaman aşımına uğradı.");
  } else if (registerResponse.statusCode == 500) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nSunucuda bir sorun oluştu.");
  } else if (registerResponse.statusCode == 502) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nHatalı ağ geçidi ile karşılaşıldı.");
  } else if (registerResponse.statusCode == 503) {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nServis ulaşılabilir değildir.");
  } else {
    return HttpStatusCodeReponses(
        isError: true,
        statusCode: registerResponse.statusCode,
        codeMessage: "Hata Kodu : ${registerResponse.statusCode}\n\nBir hata ile karşılaşıldı.");
  }
}
