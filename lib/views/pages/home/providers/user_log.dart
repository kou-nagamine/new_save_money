import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'save.dart';
import 'dart:convert';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  // 初期状態として空のリストを返す
  @override
  List<Save> build() {
    //このプロバイダーがDisposeされた時に出力される
    ref.onDispose((){log('Dispose');});
    _loadFromPreferences();
    return [];
  }

  Future<void> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('user_logs') ?? [];
    state = savedData.map((data) => Save.fromJson(jsonDecode(data))).toList();
  }

  // SharedPreferencesにデータを保存する
  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = state.map((save) => jsonEncode(save.toJson())).toList();
    await prefs.setStringList('user_logs', savedData);
  }

  // データを追加する関数
  void updateState(Save newData) {
    state = [newData, ...state];
    print("newState: $state");
    _saveToPreferences();
  }

  // データを削除する関数
  void deleteLog(int index) {
    if (index >= 0 && index < state.length) {
      // インデックスがリストの範囲内であることを確認する
      final newState = List<Save>.from(state);
      newState.removeAt(index); // 指定したインデックスの項目を削除
      state = newState;
      _saveToPreferences();  // 更新された状態を反映
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
    _saveToPreferences();
  }

  // リストを空にリセットする関数
  void resetLogs() {
    state = []; // 状態を空のリストにリセット
    _saveToPreferences();
  }
}
