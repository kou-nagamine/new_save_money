import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';

class CategoryBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // それぞれのコンテナの幅の割合
    double drinkPercentage = 0.67; // 67%
    double foodPercentage = 0.20;  // 20%
    double snackPercentage = 0.10; // 10%
    double otherPercentage = 0.03; // 3%

    // 画面の横幅を取得
    double screenWidth = MediaQuery.of(context).size.width * 0.83;

    // 各コンテナの幅をパーセンテージに基づいて計算
    double drinkWidth = screenWidth * drinkPercentage;
    double foodWidth = screenWidth * foodPercentage;
    double snackWidth = screenWidth * snackPercentage;
    double otherWidth = screenWidth * otherPercentage;

    // テキストを表示するための最小幅
    double minTextWidth = 40;

    return Row(
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
            Text(
              '飲み物',
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
            Text(
              '飲み物',
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
            Text(
              '飲み物',
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
                'その他',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff5B5B5B),
              ),
            )
            else
              Text(
                '',
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