import 'package:json_annotation/json_annotation.dart';
part 'antworten.g.dart';

@JsonSerializable()
class Antworten {
  String a;
  String b;
  String c;
  String d;

  Antworten(this.a, this.b, this.c, this.d);

  factory Antworten.fromJson(Map<String, dynamic> json) => _$AntwortenFromJson(json);
  Map<String, dynamic> toJson() => _$AntwortenToJson(this);
}
