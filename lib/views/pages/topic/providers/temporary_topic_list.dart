import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temporary_topic_list.g.dart';

@Riverpod()
class TemporaryTopicListNotifier extends _$TemporaryTopicListNotifier {
  // 初期状態として空のリストを返す
  @override
  List<dynamic> build() {
    return [null, null, DateTime.now(), '', false, false, true];
  }

  void resetState() {
    state = [null, null, DateTime.now(), '', false, false, true];
  }

  // データを追加する関数（新しいリストを作成してstateに再代入）
  void updateTitle(String title) {
    // 新しいリストを作成してstateに代入
    state = [title, state[1], state[2], state[3], state[4], state[5], state[6]];
  }

  void updatePrice(int price) {
    // 新しいリストを作成してstateに代入
    state = [state[0], price, state[2], state[3], state[4], state[5], state[6]];
  }

  void updateDate(DateTime date) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], date, state[3], state[4], state[5], state[6]];
  }

  void updateMemo(String memo) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], state[2], memo, state[4], state[5], state[6]];
  }

  void updateTitleValidate(bool validate) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], state[2], state[3], validate, state[5], state[6]];
  }

  void updatePriceValidate(bool validate) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], state[2], state[3], state[4], validate, state[6]];
  }

  void updateMemoValidate(bool validate) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], state[2], state[3], state[4], state[5], validate];
  }
}