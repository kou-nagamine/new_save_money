import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.isEmpty) {
      // 空文字の場合、デフォルトの日付を設定
      return DateTime(9999, 1, 1);
    }

    try {
      return DateFormat('yyyy-MM-dd').parse(json); // 必要なフォーマットに合わせて調整
    } catch (e) {
      throw FormatException('Invalid date format: $json');
    }
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String(); // DateTimeをISO 8601形式に変換
  }
}