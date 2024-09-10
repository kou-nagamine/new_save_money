import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//riverpods
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';
import 'package:new_save_money/views/pages/home/providers/user_log.dart';

class CategoryBarChart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPrice = ref.watch(allPriceNotifierProvider); 
    final userData = ref.watch(userLogNotifierProvider);
    final Map<String, Map<String, dynamic>> categoryData = {};

      // userData の各要素に対して処理を行う
    for (var save in userData) {
      if (categoryData.containsKey(save.name)) {
        categoryData[save.name]!['totalPrice'] += save.price;
      } else {
        categoryData[save.name] = {
          'totalPrice': save.price,
        };
      }
    }
    // allPrice[1] が存在し、かつ 0 でないことを確認して、ゼロ割りを回避する
    double totalAmount = (allPrice.length > 1 && allPrice[0] != 0)
    ? allPrice[0].toDouble()
    : 1.0; // allPrice[1] が 0 または存在しない場合は 1.0 を使用

    // それぞれのコンテナの幅の割合
    double drinkPercentage = ((categoryData['飲み物']?['totalPrice'] ?? 0 ) / totalAmount).toDouble();
    double foodPercentage = ((categoryData['食事']?['totalPrice'] ?? 0 ) / totalAmount).toDouble();
    double snackPercentage = ((categoryData['菓子類']?['totalPrice'] ?? 0 ) / totalAmount).toDouble();
    double otherPercentage = ((categoryData['その他']?['totalPrice'] ?? 0 ) / totalAmount).toDouble();

    // 画面の横幅を取得
    double screenWidth = MediaQuery.of(context).size.width * 0.83;

    // 各コンテナの幅をパーセンテージに基づいて計算
    double drinkWidth = screenWidth * drinkPercentage;
    double foodWidth = screenWidth * foodPercentage;
    double snackWidth = screenWidth * snackPercentage;
    double otherWidth = screenWidth * otherPercentage;

    // テキストを表示するための最小幅
    double minTextWidth = 70;

    return allPrice[1] == 0
      ? Container(
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            side: BorderSide(
              color: Color(0xffDADADA),
              width: 1,
            ),
            borderRadius: SmoothBorderRadius(
              cornerRadius: 5,
              cornerSmoothing: 0.6),
          ),
        ),
        height: 50,
        width: screenWidth,
        alignment: Alignment.center,
        child: Text(
          'データがないためグラフを表示できません',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ) 
      : Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xff0071FF),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 5,
                      cornerSmoothing: 0.6),
                  )),
                width: drinkWidth,
                height: 50,
              ),
            ),
            if (drinkWidth >= minTextWidth) // コンテナの幅がminTextWidth以上の場合のみ表示
              Text(
                '飲み物 ${(drinkPercentage * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
            else
              Text(
                '...',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
          ],
        ),
        SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
              decoration: ShapeDecoration(
                  color: Color(0xffFF9500),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 5,
                      cornerSmoothing: 0.6),
                  )),
                width: foodWidth,
                height: 50,
              ),
            ),
            if (foodWidth >= minTextWidth) // コンテナの幅がminTextWidth以上の場合のみ表示
              Text(
                '食事 ${(foodPercentage * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
            else
              Text(
                '...',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
          ],
        ),
        SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xff34C759),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 5,
                      cornerSmoothing: 0.6),
                  )),
                width: snackWidth,
                height: 50,
              ),
            ),
            if (snackWidth >= minTextWidth) // コンテナの幅がminTextWidth以上の場合のみ表示
              Text(
                '菓子類 ${(snackPercentage * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
            else
              Text(
                '...',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
          ],
        ),
        SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xffFF2D55),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 5,
                      cornerSmoothing: 0.6),
                  )),
                width: otherWidth,
                height: 50,
              ),
            ),
            if (otherWidth >= minTextWidth) // コンテナの幅がminTextWidth以上の場合のみ表示
              Text(
                'その他 ${(otherPercentage * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
            else
              Text(
                '...',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
          ],
        ),
      ],
    );
  }
}