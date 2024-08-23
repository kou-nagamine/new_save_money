import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  // 初期状態として空のリストを返す
  @override
  List<Map<String, dynamic>> build() {
    //このプロバイダーがDisposeされた時に出力される
    ref.onDispose((){log('Dispose');});
    return [];
  }

  // データを追加する関数
  void updateState(Map<String, dynamic> newData) {
    // 現在のデータをコピーして新しいデータを追加
    final oldState = state;
    final newState = [newData, ...oldState];
    state = newState; // 状態を更新
    print("newState: $newState");
  }

// データを削除する関数
void deleteLog(int index) {
  if (index >= 0 && index < state.length) {
    // インデックスがリストの範囲内であることを確認する
    final newState = List<Map<String, dynamic>>.from(state);
    newState.removeAt(index); // 指定したインデックスの項目を削除
    state = newState; // 更新された状態を反映
  } else {
    // 範囲外のインデックスに対する処理（エラーハンドリング）
    print('Invalid index: $index');
  }
}

  // データを元に戻す関数
  void undoDelete(int index, Map<String, dynamic> item) {
    final oldState = state;
    final newState = List<Map<String, dynamic>>.from(oldState);
    newState.insert(index, item);
    state = newState;
  }
}
