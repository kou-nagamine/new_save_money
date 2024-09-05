import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Color 用のカスタムコンバータ
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}