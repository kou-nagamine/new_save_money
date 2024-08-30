import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_price.g.dart';


@Riverpod(keepAlive: true)
class AllPriceNotifier extends _$AllPriceNotifier{
  @override
  List<int> build() {
    return [0,0]; //[我慢合計額, 支払い額込み金額]
  }

  void updateAllPrice(int price) {
    if(price != 0){
      state[0] += price;
      state[1] += price;
    } 
  }

  void subtractPrice(int price) {
    if (price != 0) {
      state[1] -= price;
    }
  }
}