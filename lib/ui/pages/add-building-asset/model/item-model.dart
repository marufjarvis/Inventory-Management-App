// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String title;
  final String district;
  final String thana;
  final String? building;
  final int id;

  ItemModel(
      {required this.title,
      required this.district,
      required this.thana,
      required this.id,
      this.building});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'district': district,
      'building': building,
      'thana': thana,
      'id': id,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      title: map['title'] as String,
      district: map['district'] as String,
      thana: map['thana'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
