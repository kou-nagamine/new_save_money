import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'save.dart';
import 'dart:convert';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  List<Save> usedLogs = [];
  List<Save> inUseLogs = [];
  List<Save> unUsedLogs = [];

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

  void updateLogsBasedOnPrice(int targetPrice) {
  int total = 0;

  for (var log in state) {
    if (!log.deposit && total < targetPrice) {
      if (total + log.price <= targetPrice) {
        log = log.copyWith(
          status: SaveStatus.used, 
          usedAmount: log.price,
          remainingPercentage: 0.0, // 完全に使用されたため残りは0%
        );
        usedLogs.add(log);
        total += log.price;
      } else {
        int usedAmount = targetPrice - total; // 使用される金額
        double remaining = 1 - (usedAmount / log.price); // 残りの割合を計算
        log = log.copyWith(
          status: SaveStatus.inUse, 
          usedAmount: usedAmount,
          remainingPercentage: remaining, // 残りの割合を設定
        );
        inUseLogs.add(log);
        total = targetPrice;
      }
    } else {
      log = log.copyWith(
        status: SaveStatus.unUsed,
        remainingPercentage: 1.0, // 未使用なので100%残っている
      );
      unUsedLogs.add(log);
    }
  }
    // ステートが更新されたことをRiverpodに通知
    state = [...state];
    _saveToPreferences();
  }
}
