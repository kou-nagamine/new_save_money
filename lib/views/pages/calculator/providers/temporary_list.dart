import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'temporary_list.g.dart';

@Riverpod(keepAlive: true)
class TemporaryListNotifier extends _$TemporaryListNotifier {
  // 初期状態として空のリストを返す
  @override
  List<dynamic> build() {
    return ['飲み物', Icons.local_drink, Colors.blue];
  }
  void resetState() {
    state = ['飲み物', Icons.local_drink, Colors.blue];
  }
  // データを追加する関数
  void updateState(dynamic newData) {
    // 現在のデータをコピーして新しいデータを追加
    state = newData; // 状態を更新
    print("$newData");
  }
}