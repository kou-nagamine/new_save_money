import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_price.g.dart';


@Riverpod(keepAlive: true)
class AllPriceNotifier extends _$AllPriceNotifier{
  @override
  int build() {
    return 0;
  }

  void updateAllPrice(int price) {
    if(price != 0){
      state += price;
    } 
  }

  void subtractPrice(int price) {
    if (price != 0) {
      state -= price;
    }
  }
}