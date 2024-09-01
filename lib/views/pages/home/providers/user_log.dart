import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'save.dart';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  // 初期状態として空のリストを返す
  @override
  List<Save> build() {
    //このプロバイダーがDisposeされた時に出力される
    ref.onDispose((){log('Dispose');});
    return [];
  }

  // データを追加する関数
  void updateState(Save newData) {
    state = [newData, ...state];
    print("newState: $state");
  }

  // データを削除する関数
  void deleteLog(int index) {
    if (index >= 0 && index < state.length) {
      // インデックスがリストの範囲内であることを確認する
      final newState = List<Save>.from(state);
      newState.removeAt(index); // 指定したインデックスの項目を削除
      state = newState; // 更新された状態を反映
    } else {
      // 範囲外のインデックスに対する処理（エラーハンドリング）
      print('Invalid index: $index');
    }
  }

  // データを元に戻す関数
  void undoDelete(int index, Save save) {
    final oldState = state;
    final newState = List<Save>.from(oldState);
    newState.insert(index, save);
    state = newState;
  }
}
