// import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'save.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

part 'user_log.g.dart';

@Riverpod(keepAlive: true)
class UserLogNotifier extends _$UserLogNotifier {
  List<Save> changedLogs = [];

  // 初期状態として空のリストを返す
  @override
  List<Save> build() {
    // このプロバイダーがDisposeされた時に出力される
    // ref.onDispose(() {
    //   log('Dispose');
    // });
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

  void updateState(Save newData) {
    var uuid = Uuid();
    if (!newData.deposit) {
    newData = newData.copyWith(linkedDepositId: uuid.v4());
    }
    // log('Adding new log: ${newData.name}, Price: ${newData.price}, id: ${newData.linkedDepositId}, Deposit: ${newData.deposit}');
    state = [newData, ...state];
    _saveToPreferences();
  }

  // データを削除する関数
  void deleteLog(int index) {
    if (index >= 0 && index < state.length) {
      final logToDelete = state[index];
      // 出金ログを削除する場合
      if (!logToDelete.deposit) {
        onDeleteWithdrawal(logToDelete);
      }
      // インデックスがリストの範囲内であることを確認する
      final newState = List<Save>.from(state);
      newState.removeAt(index); // 指定したインデックスの項目を削除
      state = newState;
      _saveToPreferences(); // 更新された状態を反映
    } else {
      _saveToPreferences();
    }
  }

  void onDeleteWithdrawal(Save withdrawalLog) {
    List<Save> updatedLogs = [];
    for (var log in state) {
      // 出金と同じidを持った入金logを探す
      if (log.deposit && log.linkedWithdrawals.any((w) => w.id == withdrawalLog.linkedDepositId)) {
        var matchingWithdrawals = log.linkedWithdrawals.where((w) => w.id == withdrawalLog.linkedDepositId).toList();
        // 該当のlogのusedAmount,remainingPercentage, statusをリセットする 
        if (matchingWithdrawals.isNotEmpty) {
          int totalAmountToRevert = matchingWithdrawals.fold(0, (sum, withdrawal) => sum + withdrawal.amount);

          log = log.copyWith(
            usedAmount: log.usedAmount - totalAmountToRevert,
            remainingPercentage: (log.price - (log.usedAmount - totalAmountToRevert)) / log.price,
            status: (log.usedAmount - totalAmountToRevert) == 0 ? SaveStatus.unUsed : SaveStatus.inUse,
            linkedWithdrawals: log.linkedWithdrawals.where((w) => w.id != withdrawalLog.linkedDepositId).toList(),
          );
        }
      }
      updatedLogs.add(log);
    }

    // `state`を正しく更新し、リビルドを促す
    state = updatedLogs;
    _saveToPreferences();
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

    // 最新の出費ログ（deposit == false）のIDを取得
    String? expenditureId;
    for (var log in state) {
      if (!log.deposit) {
        expenditureId = log.linkedDepositId;
        break; // 最初に見つかったものを使用する
      }
    }

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
        // 出費のIDが存在する場合、それを使用する
        String linkedId = expenditureId ?? Uuid().v4(); // 出費のIDがない場合は新規生成

        while (total < targetPrice && log.remainingPercentage > 0) {
          int remainingTarget = targetPrice - total; // 割り当て可能な残りの金額
          int remainingLogValue = (log.price * log.remainingPercentage).toInt(); // ログの残りの金額

          if (remainingTarget >= remainingLogValue) {
            // 全額使用できる場合
            log = log.copyWith(
              status: SaveStatus.used,
              usedAmount: log.price,
              remainingPercentage: 0.0,
              linkedWithdrawals: [
                ...log.linkedWithdrawals,
                Withdrawal(id: linkedId, amount: remainingLogValue) // 使用履歴を追加
              ],
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
              linkedWithdrawals: [
                ...log.linkedWithdrawals,
                Withdrawal(id: linkedId, amount: usedAmount) // 使用履歴を追加
              ],
            );
            total += usedAmount; // 割り当てた分だけtotalに加算
          }

          // デバッグログを追加してIDを確認
          print('Updating log: ${log.name}, Deposit ID: ${linkedId}');
          for (var withdrawal in log.linkedWithdrawals) {
            print('Withdrawal ID: ${withdrawal.id}, Amount: ${withdrawal.amount}');
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
