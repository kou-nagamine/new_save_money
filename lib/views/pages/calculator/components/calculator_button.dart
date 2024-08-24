//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//riverpods
import '../providers/add_price.dart';
import '../providers/charge_riverpod.dart';
import '../providers/all_price.dart';
import '/views/pages/home/providers/user_log.dart';
//import '../../../riverpods/add_day_riverpod.dart';

//pages
import './calculator.dart';

//commons
import '../../commons/navigation_bar/navigation_bar.dart';
class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({
    super.key,
    required this.buttonText,
    this.categoryData,
    this.isEnabled = true, //　金額が0の場合ボタンを押せないようにするので、そこで使用する変数です。 デフォルトはtrue
  });

  final String buttonText;
  final List<dynamic>? categoryData; // カテゴリーデータ（オプション）
  final bool isEnabled; // ボタンの有効/無効状態

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
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
          onPressed: isEnabled ? () {
            final chargeNotifier = ref.read(chargeRiverpodNotifierProvider.notifier);

            if (RegExp(r'^\d$').hasMatch(buttonText)) {
              chargeNotifier.addNumber(buttonText);
            } else if (buttonText == 'del') {
              chargeNotifier.deleteNumber();
            } else if (buttonText == 'C') {
              chargeNotifier.cancelCharge(); 
            } else if (buttonText == '税') {
              chargeNotifier.tax_include(); 
            } else if (buttonText == '→' && int.parse(chageState) != 0) {
              chargeNotifier.cancelCharge(); 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommonNavigationBar()),
              );
              final allNotifier = ref.read(allPriceNotifierProvider.notifier); 
              allNotifier.updateAllPrice(int.parse(chageState));

              final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
              userLogNotifier.updateState({
                // カテゴリ名を設定。categoryDataがnullでなく、かつ空でない場合はcategoryDataの最初の要素を使用。それ以外はデフォルトで'飲み物'を使用
                'categoryName': categoryData != null && categoryData!.isNotEmpty ? categoryData![0] : '飲み物',
                // カテゴリアイコンを設定。categoryDataがnullでなく、かつ2つ以上の要素がある場合はcategoryDataの2番目の要素を使用。それ以外はデフォルトでIcons.local_drinkを使用
                'categoryIcon': categoryData != null && categoryData!.length > 1 ? categoryData![1] : Icons.local_drink,
                // カテゴリカラーを設定。categoryDataがnullでなく、かつ3つ以上の要素がある場合はcategoryDataの3番目の要素を使用。それ以外はデフォルトでColors.blackを使用
                'color': categoryData != null && categoryData!.length > 2 ? categoryData![2] : Colors.black,
                // 価格を設定。チャージ状態を整数に変換して設定
                'price': int.parse(chageState),
              });
              print("chageState: $chageState"); 
            }
          } : null, // isEnabledがfalseの場合はボタンを無効化
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero, // ボタンの内側の余白をなしに設定
            backgroundColor: isEnabled ? Colors.white : Colors.grey, // isEnabledに基づいて背景色を変更
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), 
            ),
            alignment: Alignment.center, 
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.bold, 
              color: isEnabled ? Colors.black : Colors.grey, // isEnabledに基づいてテキストの色を変更
            ),
          ),
        ),
      ),
    );
  }
}

// 00のボタンのみサイズが異なる専用のウィジェット
class BigCalculatorButton extends ConsumerWidget {
  const BigCalculatorButton({
    super.key,
    required this.buttonText,
    this.isEnabled = true, //　金額が0の場合ボタンを押せないようにするので、そこで使用する変数です。 デフォルトはtrue
  });

  final String buttonText; 
  final bool isEnabled; // ボタンの有効/無効状態

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(6.5),
      child: Container(
        height: size.height * 0.095, 
        width: size.height * 0.21, 
        child: ElevatedButton(
          onPressed: isEnabled ? () {
            final chargeNotifier = ref.read(chargeRiverpodNotifierProvider.notifier); 
            chargeNotifier.addNumber('$buttonText'); 
          } : null, // isEnabledがfalseの場合はボタンを無効化
          style: ElevatedButton.styleFrom(
            elevation: 0, 
            alignment: Alignment.center,
            backgroundColor: isEnabled ? Colors.white : Colors.grey[300], // isEnabledに基づいて背景色を変更
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            buttonText, 
            style: TextStyle(
              fontSize: size.width * 0.1, 
              fontWeight: FontWeight.bold, 
              color: isEnabled ? Colors.black : Colors.grey, // isEnabledに基づいてテキストの色を変更
            ),
          ),
        ),
      ),
    );
  }
}