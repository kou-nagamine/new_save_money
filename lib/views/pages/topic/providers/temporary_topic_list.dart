import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temporary_topic_list.g.dart';

@Riverpod(keepAlive: true)
class TemporaryTopicListNotifier extends _$TemporaryTopicListNotifier {
  // 初期状態として空のリストを返す
  @override
  List<dynamic> build() {
    return ['サークル会食',700,DateTime.now(),''];
  }
  void updateState(List<dynamic> newState) {
    state = newState;
  }
  // データを追加する関数
  void updateTitle (String title) {
    state[0] = title;
  }
  void updatePrice (int price) {
    state[1] = price;
  }
  void updateDate (DateTime date) {
    state[2] = date;
  }
  void updateMemo (String memo) {
    state[3] = memo;
  }
}