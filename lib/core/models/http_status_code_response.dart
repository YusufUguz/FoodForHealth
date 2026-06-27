// ignore_for_file: public_member_api_docs, sort_constructors_first
class HttpStatusCodeReponses {
  bool isError;
  int statusCode;
  String codeMessage;

  HttpStatusCodeReponses({
    required this.isError,
    required this.statusCode,
    required this.codeMessage,
  });
}
