import 'package:json_annotation/json_annotation.dart';

part 'composition.g.dart';

@JsonSerializable()
class Composition {
  final String label;
  final String description;
  final String creationDate;
  final String imageUri;

  Composition({
    required this.label,
    required this.description,
    required this.creationDate,
    required this.imageUri,
  });

  factory Composition.fromJson(Map<String, dynamic> json) =>
      _$CompositionFromJson(json);

  Map<String, dynamic> toJson() => _$CompositionToJson(this);
}
