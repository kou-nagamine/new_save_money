import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'charge_riverpod.g.dart';

@riverpod
class ChargeRiverpodNotifier extends _$ChargeRiverpodNotifier {
  int taxState = 0; // 0: 税なし, 1: 8% 税, 2: 10% 税
  String originalState = '0'; // 税率変更前の元の値を保持

  @override
  String build() {
    return '0';
  }

  // 数字ボタン　
  void addNumber(String number) {
    if (state == '0') {
      state = number;
    } else {
      int newState = int.parse(state + number);
      if (newState <= 9999) {
        state = state + number;
      }
    }
    originalState = state; // 数字が変更されたら元の値を更新
    taxState = 0; // 数字が変更されたら税率をリセット
  }

  // delete ボタン
  void deleteNumber() {
    if (int.parse(state) != 0) {
      if (state.length == 1) {
        state = '0';
      } else {
        state = state.substring(0, state.length - 1);
      }
    }
    originalState = state; // 削除後も元の値を更新
    taxState = 0; // 税率をリセット
  }

  // state を 0 にする
  void cancelCharge() {
    state = '0';
    originalState = state; // リセット時に元の値も更新
    taxState = 0; // 税率をリセット
  }

  // 税ボタンの動作
  void tax_include() {
    if (taxState == 0) {
      // 8% 税を適用
      double newState = double.parse(originalState) * 1.08;
      state = newState.floor().toString();
      taxState = 1;
    } else if (taxState == 1) {
      // 10% 税を適用
      double newState = double.parse(originalState) * 1.10;
      state = newState.floor().toString();
      taxState = 2;
    } else {
      // 元の値に戻す
      state = originalState;
      taxState = 0;
    }
  }
}