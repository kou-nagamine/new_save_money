import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//converter
import '../../../../converters/icon_data_converter.dart';
import '../../../../converters/color_converter.dart';

part 'save.freezed.dart';
part 'save.g.dart';

@freezed
class Save with _$Save {
  @JsonSerializable(explicitToJson: true)
  const factory Save({
    required String name,
    required int price,
    @IconDataConverter() required IconData icon,
    @ColorConverter() required Color color,
    required String dataTime,
    required String memo,
    @Default(true) bool deposit,
  }) =_Save;

  factory Save.fromJson(Map<String, dynamic> json) => _$SaveFromJson(json);
}