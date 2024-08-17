import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'charge_riverpod.g.dart';

@riverpod
class ChargeRiverpodNotifier extends _$ChargeRiverpodNotifier{

  @override
  String build() {
    return '0';
  }

  //数字ボタン　
  //9999円までの記載は可
  void addNumber(String number) {
  if (state == '0') {
    state = number;
  } else {
      int newState = int.parse(state + number);
      if (newState <= 9999) {
        state = state + number;
      }
    }
  }

  //deletボタン
  //値が一桁なら0, 二桁以上なら最小の桁を削除
  void deleteNumber() {
    if (int.parse(state) != 0) {
      if (state.length == 1) {
        state = '0';
      } else {
        state = state.substring(0, state.length - 1);
      } 
    }
  }

  //stateを0にする
  void cancelCharge(){
    state = '0';
  }

  //税ボタン
  void tax_include() {
    //小数点以下は切り捨てる
    double newState = double.parse(state) * 1.08;
    int intState = newState.floor();
    state = intState.toString();
  }
}