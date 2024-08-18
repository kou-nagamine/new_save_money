//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//riverpods
import '../providers/add_price.dart';
import '../providers/charge_riverpod.dart';
//import '../../../riverpods/add_day_riverpod.dart';

//commons
import '../../commons/navigation_bar/navigation_bar.dart';

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({super.key, required this.buttonText});
  final String buttonText;
  
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
            //曜日別グラフの値に変更加える機能を全て取得
            //final addDayNotifier = ref.watch(addDayRiverpodNotifierProvider.notifier); 
            //weeklyグラフの値に変更を加える
            final addWeeklyNotifier = ref.watch(addPriceRiverpodNotifierProvider.notifier);

            //buttonTextの値ごとの処理を記載
            if (RegExp(r'^\d$').hasMatch(buttonText)) {
              chargeNotifier.addNumber(buttonText);
            } else if (buttonText == 'del') {
              chargeNotifier.deleteNumber();
            } else if (buttonText == 'C') {
              chargeNotifier.cancelCharge();
            } else if (buttonText == '税'){
              chargeNotifier.tax_include();
            } else if (buttonText == '→'){
              //第一引数で曜日を管理（月:0,火:1,水:2...）
              //addDayNotifier.addUpdateDay(1,int.parse(chageState));
              addWeeklyNotifier.weeklyAddUpdate(int.parse(chageState));
              chargeNotifier.cancelCharge();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonNavigationBar()),
              );
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