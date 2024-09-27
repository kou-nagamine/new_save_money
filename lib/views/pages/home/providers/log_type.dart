import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_type.g.dart';

// showPopUpの状態を管理するクラス
@riverpod
class ShowPopUpNotifier extends _$ShowPopUpNotifier {
  @override
  List<bool> build() {
    return [true,false,false]; // 全体・ついで収入・支出
  }

  
}