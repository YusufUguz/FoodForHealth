import 'dart:convert';

List<Disease> diseaseFromJson(String str) =>
    List<Disease>.from(json.decode(str).map((x) => Disease.fromJson(x)));

String diseaseToJson(List<Disease> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Disease {
  int id;
  String diseaseName;

  Disease({
    required this.id,
    required this.diseaseName,
  });

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        id: json["id"],
        diseaseName: json["diseaseName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diseaseName": diseaseName,
      };
}
