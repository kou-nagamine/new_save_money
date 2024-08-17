import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_price.g.dart';

@riverpod
class AddPriceRiverpodNotifier extends _$AddPriceRiverpodNotifier {
  @override
  List<int> build() {
    _loadFromPrefs();
    return [0, 0];
  }

  // SharedPreferencesのインスタンスを取得するヘルパーメソッド
  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  // SharedPreferencesからデータをロードするメソッド
  Future<void> _loadFromPrefs() async {
    final prefs = await _prefs();
    final weeklyValue = prefs.getInt('weeklyValue') ?? 0;
    final totalValue = prefs.getInt('totalValue') ?? 0;
    state = [weeklyValue, totalValue];
  }

  // SharedPreferencesのweeklyValueにstate[0]をとtotalValueにstate[1]
  Future<void> _saveToPrefs() async {
    final prefs = await _prefs();
    prefs.setInt('weeklyValue', state[0]);
    prefs.setInt('totalValue', state[1]);
  }

  // 週間で保持しているstateとprfsをリセットする
  Future<void> _resetWeeklyPrefs() async {
    final prefs = await _prefs();
    await prefs.remove('weeklyValue');
    state = [0,state[1]];
  }

  // 電卓で入力された値を１週間のデータに値を足す
  void weeklyAddUpdate(int pricevalue) {
    state = [...state]..[0] += pricevalue;
    _saveToPrefs();
  }

  // 1週間のデータを全てを足して, 1週間のデータを0にする
  void allAddUpdate() {
    state = [...state]..[1] += state[0];
    state[0] = 0;
    _saveToPrefs();
  }

  void resetWeeklyValues() {
    _resetWeeklyPrefs();
  }
}