import 'dart:convert';

List<TypeModel> typeFromMap(List list) =>
    List<TypeModel>.from(list.map((x) => TypeModel.fromJsonType(x)));

class TypeModel {
  TypeModel({this.id, this.name});
  int? id;
  String? name;

  factory TypeModel.fromJsonType(Map<String, dynamic> json) =>
      TypeModel(id: json["id"], name: json["tr_name"]);
}
