import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//converter
import '../converters/icon_data_converter.dart';
import '../converters/color_converter.dart';
import '../converters/date_converter.dart';

part 'save.freezed.dart';
part 'save.g.dart';

// Enumを使って状態を定義
enum SaveStatus { used, inUse, unUsed }

@freezed
class Save with _$Save {
  const factory Save({
    required String name,
    required int price,
    @IconDataConverter() required IconData icon,
    @ColorConverter() required Color color,
    @DateTimeConverter() required DateTime dataTime, // DateTimeConverterを適用
    required String memo,
    @Default('') String imageUrl, // デフォルト値を設定
    @Default(true) bool deposit,
    @Default(SaveStatus.unUsed) SaveStatus status, // 状態を示すプロパティを追加
    @Default(0) int usedAmount, // 使用された金額を追跡するプロパティを追加
    @Default(1.0) double remainingPercentage, // 残りの割合を追跡するプロパティを追加
    String? linkedDepositId, //入金と出金を紐づけられるための出金につけられるID
    @Default([]) List<Withdrawal> linkedWithdrawals,
    @Default(0.0) double? salePercentage,
  }) =_Save;

  factory Save.fromJson(Map<String, dynamic> json) => _$SaveFromJson(json);
}

@freezed
class Withdrawal with _$Withdrawal {
  const factory Withdrawal({
    required String id, //　ある出金で使われた入金につけられるID
    required int amount, // 使用された金額
  }) = _Withdrawal;

  factory Withdrawal.fromJson(Map<String, dynamic> json) => _$WithdrawalFromJson(json);
}



