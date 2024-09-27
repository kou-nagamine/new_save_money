import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final numberFormat = NumberFormat("#,##0"); // 3桁ごとにカンマをつけるフォーマット


// LineChartDataを生成する関数
LineChartData createLineChartData(List<FlSpot> flSpots, List<String> dates) {
  //bool showDates = dates.length <= 10; // データが10個以上かどうかを判定する
  return LineChartData(
    borderData: FlBorderData(
      border: const Border(
        top: BorderSide(color: Color(0xffE5E5E5)),
        right: BorderSide.none,
        left: BorderSide.none,
        bottom: BorderSide(color: Color(0xffE5E5E5)),
      ),
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          //showTitles: showDates, // データが10個以上の場合のみ日付を表示する
          showTitles: false,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, dates),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    gridData: const FlGridData(show: false),
    lineBarsData: [
      LineChartBarData(
        spots: flSpots,
        isCurved: true, // カーブを使用する
        curveSmoothness: 0.01, // 0.0 ～ 1.0 の値を指定（0.2 は軽く曲線になる）
        preventCurveOverShooting: true,
        color: const Color(0xff0092FB),
        barWidth: 5,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              Color(0xff00C6FB).withOpacity(0.4),
              Color(0xff00C6FB).withOpacity(0.2),
              Color(0xff00C6FB).withOpacity(0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        dotData: const FlDotData(show: false),
      ),
    ],
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (LineBarSpot touchedBarSpot) {
          return Colors.black.withOpacity(0.8);
        },
        getTooltipItems: (List<LineBarSpot> touchedSpots) {
          return touchedSpots.map((LineBarSpot touchedSpot) {
            const textStyle = TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            String formattedValue = numberFormat.format(touchedSpot.y);
            int index = touchedSpot.x.toInt();
            
            // インデックスが有効かどうかをチェック
            if (index < 0 || index >= dates.length) {
              return LineTooltipItem(
                '￥$formattedValue', // 値のみ表示
                textStyle,
              );
            } 
            String date = dates[index]; // x値に基づいて日付を取得
            return LineTooltipItem(
              '$date\n￥$formattedValue',
              textStyle,
            );
          }).toList();
        },
        tooltipPadding: const EdgeInsets.all(10),
        tooltipMargin: 200,
        fitInsideHorizontally: true,
        fitInsideVertically: true,
      ),
      getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
        return spotIndexes.map((index) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.black, strokeWidth: 4),
            FlDotData(show: true),
          );
        }).toList();
      },
    ),
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta, List<String> dates) {
  const style = TextStyle(
    color: Colors.black38,
    fontWeight: FontWeight.w300,
    fontSize: 8,
  );

  String text = '';
  // valueがdatesの範囲内であれば対応する日付を表示
  if (value.toInt() >= 0 && value.toInt() < dates.length) {
    text = dates[value.toInt()];
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Padding(
      padding: const EdgeInsets.only(left: 20), // 余白を追加 (右側にテキストを表示するため)
      child: Text(text, style: style),
    ),
  );
}

// LineChartData savedData(){
//   return LineChartData(
//     borderData: FlBorderData(
//       border: const Border(
//         top: BorderSide(color: Color(0xffE5E5E5)),
//         right: BorderSide.none,
//         left: BorderSide.none,
//         bottom: BorderSide(color: Color(0xffE5E5E5)),
//       )
//     ),
//     titlesData: const FlTitlesData(
//       show: true,
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           interval: 1,
//           getTitlesWidget: bottomTitleWidgets,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//     ),
//     //grid
//     gridData: const FlGridData(
//       show:false,
//     ),
//     lineBarsData: [
//       LineChartBarData(
//         spots:const [
//           FlSpot(-1,0),
//           FlSpot(0,163),
//           FlSpot(1,370),
//           FlSpot(2,700),
//           FlSpot(3,765),
//           FlSpot(4,585),
//           FlSpot(5,1076),
//           FlSpot(6,297),
//           FlSpot(7,842),
//           FlSpot(8,1342),
//           FlSpot(9,798),
//           FlSpot(10,1479),
//           FlSpot(11,608),
//           FlSpot(12,754),
//           FlSpot(13,1087),
//           FlSpot(14,1461),
//           FlSpot(15,2067),
//           FlSpot(16,1783),
//           FlSpot(17,2213),
//           FlSpot(18,2043),
//           FlSpot(19,2183),
//           FlSpot(20,2383),
//         ],
//         color: Color(0xff0092FB),
//         // gradient: const LinearGradient(
//         //   colors:[
//         //     Color(0xff00C6FB),
//         //     Color(0xff005BEA),
//         //   ],
//         // ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff00C6FB).withOpacity(0.4),
//               Color(0xff00C6FB).withOpacity(0.2),
//               Color(0xff00C6FB).withOpacity(0.0),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         barWidth: 5,
//         isCurved: true,
//         curveSmoothness: 0.15,
//         dotData: const FlDotData(
//           show: false,
//         ),
//       ),
//     ],
//     lineTouchData: LineTouchData(
//       touchTooltipData: LineTouchTooltipData(
//         getTooltipColor: (LineBarSpot touchedBarSpot) {
//           return Colors.black.withOpacity(0.8);
//         },
//         getTooltipItems: (List<LineBarSpot> touchedSpots) {
//           return touchedSpots.map((LineBarSpot touchedSpot) {
//             const textStyle = TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             );
//             String formattedValue = numberFormat.format(touchedSpot.y);
//             return LineTooltipItem(
//               '￥$formattedValue',  // フォーマットされた値を表示
//               textStyle,
//             );
//           }).toList();
//         },
//         tooltipPadding: const EdgeInsets.all(10),
//         tooltipMargin: 200,  // グラフとツールチップ間の余白
//         fitInsideHorizontally: true,  // ツールチップが画面の外に出ないようにする設定
//         fitInsideVertically: true,  // 垂直方向も画面に収まるように設定
//         rotateAngle: 0,  // ツールチップの回転角度
//       ),
//       getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
//         return spotIndexes.map((index) {
//           return TouchedSpotIndicatorData(
//             FlLine(color: Colors.black, strokeWidth: 4),  // 垂直線の色と太さ
//             FlDotData(show: true),
//           );
//         }).toList();
//       },
//     ),
//   );
// }

// LineChartData allData(){
//    return LineChartData(
//     borderData: FlBorderData(
//       border: const Border(
//         top: BorderSide(color: Color(0xffE5E5E5)),
//         right: BorderSide.none,
//         left: BorderSide.none,
//         bottom: BorderSide(color: Color(0xffE5E5E5)),
//       )
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           interval: 1,
//           getTitlesWidget: bottomTitleWidgets,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: false,
//           reservedSize: 0,
//           ),
//       )
//     ),
//     //grid
//     gridData: const FlGridData(
//       show:false,
//     ),
//     lineBarsData: [
//       LineChartBarData(
//         spots:const [
//           FlSpot(-1,0),
//           FlSpot(0,163),
//           FlSpot(1,370),
//           FlSpot(2,700),
//           FlSpot(3,765),
//           FlSpot(4,885),
//           FlSpot(5,1076),
//           FlSpot(6,1097),
//           FlSpot(7,1142),
//           FlSpot(8,1342),
//           FlSpot(9,1378),
//           FlSpot(10,1479),
//           FlSpot(11,1608),
//           FlSpot(12,1754),
//           FlSpot(13,2087),
//           FlSpot(14,2461),
//           FlSpot(15,2667),
//           FlSpot(16,2783),
//         ],
//         color: Color(0xff0092FB),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff00C6FB).withOpacity(0.4),
//               Color(0xff00C6FB).withOpacity(0.2),
//               Color(0xff00C6FB).withOpacity(0.0),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         barWidth: 5,
//         isCurved: true,
//         curveSmoothness: 0.15,
//         dotData: const FlDotData(
//           show: false,
//         ),
//       ),
//     ],
// lineTouchData: LineTouchData(
//       touchTooltipData: LineTouchTooltipData(
//         getTooltipColor: (LineBarSpot touchedBarSpot) {
//           return Colors.black.withOpacity(0.8);
//         },
//         getTooltipItems: (List<LineBarSpot> touchedSpots) {
//           return touchedSpots.map((LineBarSpot touchedSpot) {
//             const textStyle = TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             );
//             String formattedValue = numberFormat.format(touchedSpot.y);
//             return LineTooltipItem(
//               '￥$formattedValue',  // フォーマットされた値を表示
//               textStyle,
//             );
//           }).toList();
//         },
//         tooltipPadding: const EdgeInsets.all(10),
//         tooltipMargin: 200,  // グラフとツールチップ間の余白
//         fitInsideHorizontally: true,  // ツールチップが画面の外に出ないようにする設定
//         fitInsideVertically: true,  // 垂直方向も画面に収まるように設定
//         rotateAngle: 0,  // ツールチップの回転角度
//       ),
//       getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
//         return spotIndexes.map((index) {
//           return TouchedSpotIndicatorData(
//             FlLine(color: Colors.black, strokeWidth: 4),  // 垂直線の色と太さ
//             FlDotData(show: true),
//           );
//         }).toList();
//       },
//     ),
//   );
// }

// Widget bottomTitleWidgets(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Colors.black38,
//     fontWeight: FontWeight.w300,
//     fontSize: 10,
//   );

//   // 全体の範囲
//   final double minValue = 0; // グラフの最小値
//   final double maxValue = 16; // グラフの最大値（ここはデータを元に設定する）

//   // 10%, 50%, 90% の位置を計算
//   final double tenPercent = minValue + (maxValue - minValue) * 0.1;
//   final double fiftyPercent = minValue + (maxValue - minValue) * 0.5;
//   final double ninetyPercent = minValue + (maxValue - minValue) * 0.9;

//   Widget text;
//   if ((value - tenPercent).abs() < 0.5) {
//     text = const Text('5/10', style: style); // 10% 位置に表示
//   } else if ((value - fiftyPercent).abs() < 0.5) {
//     text = const Text('6/21', style: style); // 50% 位置に表示
//   } else if ((value - ninetyPercent).abs() < 0.5) {
//     text = const Text('8/6', style: style); // 90% 位置に表示
//   } else {
//     text = const Text('', style: style); // それ以外の位置にはテキストを表示しない
//   }
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: text,
//   );
// }