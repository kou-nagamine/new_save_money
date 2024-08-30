import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save.freezed.dart';

@freezed
class Save with _$Save {
  const factory Save({
    required String name,
    required int price,
    required IconData icon,
    required Color color,
    @Default(true) bool payment,
  }) =_Save;
}