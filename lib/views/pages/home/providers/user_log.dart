import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'save.dart';
import 'dart:convert';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  List<Save> changedLogs = [];

  // 初期状態として空のリストを返す
  @override
  List<Save> build() {
    // このプロバイダーがDisposeされた時に出力される
    ref.onDispose(() {
      log('Dispose');
    });
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
      _saveToPreferences(); // 更新された状態を反映
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
    changedLogs.clear(); // 更新のたびにリセット

    // 新しいログリストを作成
    List<Save> updatedLogs = [];

    // 古いデータから順に処理するためにリストを反転
    for (var log in state.reversed) {
      final originalStatus = log.status;
      int originalUsedAmount = log.usedAmount;

      if (originalStatus == SaveStatus.used) {
        // すでにusedのものは変更せずに追加
        updatedLogs.add(log);
        continue; // 処理をスキップ
      }

      if (log.deposit && total < targetPrice) {
        while (total < targetPrice && log.remainingPercentage > 0) {
          int remainingTarget = targetPrice - total; // 割り当て可能な残りの金額
          int remainingLogValue = (log.price * log.remainingPercentage).toInt(); // ログの残りの金額

          if (remainingTarget >= remainingLogValue) {
            // 全額使用できる場合
            log = log.copyWith(
              status: SaveStatus.used,
              usedAmount: log.price,
              remainingPercentage: 0.0,
            );
            total += remainingLogValue;
          } else {
            // 部分的にしか使用できない場合
            int usedAmount = remainingTarget; // 割り当て可能な金額
            double remaining = (remainingLogValue - usedAmount) / log.price; // 残りの割合を計算
            log = log.copyWith(
              status: SaveStatus.inUse,
              usedAmount: log.price - remainingLogValue + usedAmount,
              remainingPercentage: remaining,
            );
            total += usedAmount; // 割り当てた分だけtotalに加算
          }
        }
      } else {
        // depositがfalseの場合またはtotalがtargetPrice以上の場合
        log = log.copyWith(
          status: SaveStatus.unUsed,
          remainingPercentage: 1.0,
        );
      }
      // 更新されたログを追加
      updatedLogs.add(log);

      // 状態が変わったものを追跡
      // ログの内容が変わったら追跡
      if (originalUsedAmount != log.usedAmount || originalStatus != log.status) {
        changedLogs.add(log);
      }
    }

    // 古い順で処理したのでリストを再び反転して元の順序に戻す
    state = updatedLogs.reversed.toList();

    _saveToPreferences();
  }

  // 変更されたログを取得するプロパティ
  List<Save> getChangedLogs() {
    return changedLogs;
  }
}
