import 'package:json_annotation/json_annotation.dart';
import 'antworten.dart';

/// This allows the `Themen` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'themen.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class Themen {
  Themen(this.themenId, this.themenName, this.fragenId, this.fragenName, this.antworten, this.antwortR);

  int themenId;
  String themenName;
  int fragenId;
  String fragenName;
  Antworten antworten;
  String antwortR;


  /// A necessary factory constructor for creating a new Themen instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Themen.
  factory Themen.fromJson(Map<String, dynamic> json) => _$ThemenFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ThemenToJson(this);
}
