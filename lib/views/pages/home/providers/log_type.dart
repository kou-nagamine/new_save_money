import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod/riverpod.dart';

part 'log_type.g.dart';

// showPopUpの状態を管理するクラス
@riverpod
class LogTypeNotifier extends _$LogTypeNotifier {
  @override
  Future<List<bool>> build() async {
    return await _loadFromPreferences();
  }

  // SharedPreferencesからデータを読み込む
  Future<List<bool>> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('log_type') ?? ['true', 'false', 'false'];
    return savedData.map((value) => value == 'true').toList();
  }

  // SharedPreferencesにデータを保存する
  Future<void> _saveToPreferences(List<bool> newState) async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = newState.map((value) => value.toString()).toList();
    await prefs.setStringList('log_type', savedData);
  }

  // 現在の選択状態に基づいて選択されたメニュー項目を取得する
  String getSelectedItem(List<bool> state) {
    if (state[1] == true) {
      return 'ついで収入';
    } else if (state[2] == true) {
      return '支出';
    } else {
      return '全体';
    }
  }

  // 全体を選択した時
  void selectAllType() {
    final newState = [true, false, false];
    state = AsyncValue.data(newState);
    _saveToPreferences(newState);
  }

  // ついで収入を選択したとき
  void selectDepositType() {
    final newState = [false, true, false];
    state = AsyncValue.data(newState);
    _saveToPreferences(newState);
  }

  // 出費を記録した時
  void selectExpenseType() {
    final newState = [false, false, true];
    state = AsyncValue.data(newState);
    _saveToPreferences(newState);
  }
}