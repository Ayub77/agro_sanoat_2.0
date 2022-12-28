import 'dart:convert';

List<UniversalModel> regionFromMap(List list) => List<UniversalModel>.from(
    list.map((x) => UniversalModel.fromJsonRegion(x)));

class UniversalModel {
  UniversalModel({this.id, this.name, this.lat, this.lng});
  int? id;
  String? name;
  double? lat;
  double? lng;

  factory UniversalModel.fromJsonRegion(Map<String, dynamic> json) =>
      UniversalModel(
          id: json["id"],
          name: json["tr_name"],
          lat: jsonDecode(json["location"])["lat"],
          lng: jsonDecode(json["location"])["lng"]);
}
