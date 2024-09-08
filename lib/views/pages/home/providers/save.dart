import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//converter
import '../../../../converters/icon_data_converter.dart';
import '../../../../converters/color_converter.dart';

part 'save.freezed.dart';
part 'save.g.dart';

// Enumを使って状態を定義
enum SaveStatus { used, inUse, unUsed }

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
    @Default(SaveStatus.unUsed) SaveStatus status, // 状態を示すプロパティを追加
    @Default(0) int usedAmount, // 使用された金額を追跡するプロパティを追加
    @Default(1.0) double remainingPercentage, // 残りの割合を追跡するプロパティを追加
  }) =_Save;

  factory Save.fromJson(Map<String, dynamic> json) => _$SaveFromJson(json);
}