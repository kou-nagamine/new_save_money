import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_dialog.g.dart';


// showPopUpの状態を管理するクラス
@riverpod
class ShowPopUpNotifier extends _$ShowPopUpNotifier {
  @override
  bool build() {
    return false;  // 初期状態はfalse
  }

  // ポップアップを表示するように設定
  void show() {
    state = true;
  }

  // ポップアップを非表示にするように設定
  void hide() {
    state = false;
  }
}