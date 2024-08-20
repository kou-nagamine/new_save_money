import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_log.g.dart';

@riverpod
class UserLogNotifier extends _$UserLogNotifier {
  // 初期状態として空のリストを返す
  @override
  List<Map<String, dynamic>> build() {
    return [];
  }

  // データを追加する関数
  void updateState(Map<String, dynamic> newData) {
    // 現在のデータをコピーして新しいデータを追加
    final oldState = state;
    final newState = [newData, ...oldState];
    state = newState; // 状態を更新
    print("newState: $newState");
  }
}