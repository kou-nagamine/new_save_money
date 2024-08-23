//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//riverpods
import '../providers/add_price.dart';
import '../providers/charge_riverpod.dart';
import '../providers/all_price.dart';
import '/views/pages/home/providers/user_log.dart';
//import '../../../riverpods/add_day_riverpod.dart';

//commons
import '../../commons/navigation_bar/navigation_bar.dart';

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({super.key, required this.buttonText, this.categoryData});
  final String buttonText;
  final List<dynamic>? categoryData;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    //charge金額のstateを監視
    final chageState = ref.watch(chargeRiverpodNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(6.5),
      child: Container(
        height: size.height * 0.095,
        width: size.height * 0.095,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.035),
        ),
        child: ElevatedButton(
          onPressed: (){
            //電卓の機能を全て取得
            final chargeNotifier = ref.read(chargeRiverpodNotifierProvider.notifier);

            //buttonTextの値ごとの処理を記載
            if (RegExp(r'^\d$').hasMatch(buttonText)) {
              chargeNotifier.addNumber(buttonText);
            } else if (buttonText == 'del') {
              chargeNotifier.deleteNumber();
            } else if (buttonText == 'C') {
              chargeNotifier.cancelCharge();
            } else if (buttonText == '税'){
              chargeNotifier.tax_include();
            } else if (buttonText == '→' && int.parse(chageState) != 0){
              chargeNotifier.cancelCharge();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonNavigationBar()),
              );
              // 全体の値に追加
              final allNotifier = ref.read(allPriceNotifierProvider.notifier);
              allNotifier.updateAllPrice(int.parse(chageState));

              // 履歴に値を追加
              final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
              userLogNotifier.updateState({
                'categoryName': categoryData != null && categoryData!.isNotEmpty ? categoryData![0] : '飲み物',
                'categoryIcon': categoryData != null && categoryData!.length > 1 ? categoryData![1] : Icons.local_drink,
                'color': categoryData != null && categoryData!.length > 2 ? categoryData![2] : Colors.black,
                'price': int.parse(chageState),
              });
              print("chageState: $chageState");
            }
          },
          //電卓ボタンのレイアウト
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15) //こちらを適用
            ),
            alignment: Alignment.center,
          ),
          //電卓ボタンの文字のレイアウト
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.bold,
              color:Colors.black
            ),
          ),
        ),
      )
    );
  }
}

//00のボタンのみ大きさが異なるの00専用のWidget
class BigCalculatorButton extends ConsumerWidget {
  const BigCalculatorButton ({super.key, required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(6.5),
      child: Container(
        height: size.height * 0.095,
        width: size.height * 0.21,
        child: ElevatedButton(
          onPressed: (){
            final chargeNotifier = ref.read(chargeRiverpodNotifierProvider.notifier);
            chargeNotifier.addNumber('$buttonText');
          },
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15) //こちらを適用
            )
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.bold,
              color:Colors.black
            ),
          ),
        ),
      ),
    );
  }
}