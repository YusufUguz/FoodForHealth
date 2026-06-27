class ApiConstants {

  //apibaseurlye API'da launchsettingsdeki kendi ipni içeren kısmı yazmalısın örneğin http://192.168.1.1:7014
  //geminiapikey'e googleaidstudiodan oluşturduğun keyi yazmalısın
  
  static const String apiBaseUrl = "http://10.0.2.2:5016";
  static const String register = "/api/Users/register";
  static const String login = "/api/Users/login";
  static const String getdiseases = "/api/getdiseases";
  static const String getfoodbybarcode = "/api/getfoodbybarcode";
  static const String getuserinfo = "/api/getuserinfo";
  static const String createuserinfo = "/api/createuserinfo";
  static const String getuserdiseases = "/api/getuserdiseases";
  static const String createuserdisease = "/api/createuserdisease";
  static const String deleteuserdisease = "/api/deleteuserdisease";
  static const String geminiAPIKey = "";
}
