import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'all_price.g.dart';


@Riverpod(keepAlive: true)
class AllPriceNotifier extends _$AllPriceNotifier{
  @override
  List<int> build() {
    _loadFromPreferences();
    return [0,0]; //[我慢合計額, 支払い額込み金額]
  }

  // SharedPreferencesからデータを読み込む
  Future<void> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('all_price') ?? ['0', '0'];
    state = savedData.map((data) => int.parse(data)).toList();
  }

  // SharedPreferencesにデータを保存する
  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = state.map((price) => price.toString()).toList();
    await prefs.setStringList('all_price', savedData);
  }

  // データをリセットするメソッド
  Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('all_price'); // 'all_price' キーのデータを削除
    state = [0, 0]; // ステートを初期値にリセット
  }

  void updateAllPrice(int price) {
    if(price != 0){
      state[0] += price;
      state[1] += price;
      _saveToPreferences();
    } 
  }

  void subtractPrice(int price) {
    if (state[1] >= price) {
      state[1] -= price;
    }else{
      state[1] = 0;
    }
    _saveToPreferences();
  }

  void deletePrice(bool payment , int price) {
    if (payment == true) {
      state[0] -= price;
      if (state[1] < price) {
        state[1] = 0;
      }else{
        state[1] -= price;
      }
    }else{
      state[1] += price;
    }
    _saveToPreferences();
  }

  void returnPrice(bool payment ,int price) {
    if (payment == true) {
      state[0] += price;
      state[1] += price;
    }else{
      if (state[1] < price) {
        state[1] = 0;
      }else{
        state[1] -= price;
      }
    }
    _saveToPreferences();
  }
}