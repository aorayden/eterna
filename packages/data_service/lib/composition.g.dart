// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Composition _$CompositionFromJson(Map<String, dynamic> json) => Composition(
  label: json['label'] as String,
  description: json['description'] as String,
  creationDate: json['creationDate'] as String,
  imageUri: json['imageUri'] as String,
);

Map<String, dynamic> _$CompositionToJson(Composition instance) =>
    <String, dynamic>{
      'label': instance.label,
      'description': instance.description,
      'creationDate': instance.creationDate,
      'imageUri': instance.imageUri,
    };
