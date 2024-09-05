import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// IconData 用のカスタムコンバータ
class IconDataConverter implements JsonConverter<IconData, Map<String, dynamic>> {
  const IconDataConverter();

  @override
  IconData fromJson(Map<String, dynamic> json) {
    return IconData(
      json['codePoint'] as int,
      fontFamily: json['fontFamily'] as String?,
      fontPackage: json['fontPackage'] as String?,
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson(IconData icon) => {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily,
        'fontPackage': icon.fontPackage,
        'matchTextDirection': icon.matchTextDirection,
      };
}