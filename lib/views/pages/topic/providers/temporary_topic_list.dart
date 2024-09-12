import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temporary_topic_list.g.dart';

@Riverpod()
class TemporaryTopicListNotifier extends _$TemporaryTopicListNotifier {
  // 初期状態として空のリストを返す
  @override
  List<dynamic> build() {
    return [null, null, DateTime.now(), ''];
  }

  void resetState() {
    state = [null, null, DateTime.now(), ''];
  }

  // データを追加する関数（新しいリストを作成してstateに再代入）
  void updateTitle(String title) {
    // 新しいリストを作成してstateに代入
    state = [title, state[1], state[2], state[3]];
  }

  void updatePrice(int price) {
    // 新しいリストを作成してstateに代入
    state = [state[0], price, state[2], state[3]];
  }

  void updateDate(String date) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], date, state[3]];
  }

  void updateMemo(String memo) {
    // 新しいリストを作成してstateに代入
    state = [state[0], state[1], state[2], memo];
  }
}