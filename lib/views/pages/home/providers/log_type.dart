import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_type.g.dart';

// showPopUpの状態を管理するクラス
@riverpod
class LogTypeNotifier extends _$LogTypeNotifier {
  @override
  List<bool> build() {
    return [true,false,false]; // 全体・ついで収入・支出
  }

  // 全体を選択した時
  void selectAllType() {
    state = [true,false,false];
  }

  // ついで収入を選択したとき
  void selectDepositType() {
    state = [false,true,false];
  }

  // 出費を記録した時
  void selectExpenseType() {
    state = [false,false,true];
  }
}