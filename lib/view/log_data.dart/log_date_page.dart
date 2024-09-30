import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//components
import 'components/graph_data.dart';
//riverpods
import '../../view_model/all_price.dart';
import '../../view_model/user_log.dart';

//freezed
import '../../model/save.dart';

class GraphPage extends ConsumerStatefulWidget {
  const GraphPage({super.key});

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends ConsumerState<GraphPage> with SingleTickerProviderStateMixin {
  String selectedOption = 'ついで収入';
  late AnimationController _chartanimationController;
  late Animation<double> _chartanimation;

  @override
  void initState() {
    super.initState();
    _chartanimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _chartanimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartanimationController, 
        curve: Curves.easeInOutCirc,
      ),
    )..addListener(() {
        setState(() {});
      });
    _chartanimationController.forward();
  }

  @override
  void dispose() {
    _chartanimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allPrice = ref.watch(allPriceNotifierProvider); 
    final userData = ref.watch(userLogNotifierProvider);
    final Map<String, Map<String, dynamic>> categoryData = {};

    List<FlSpot> allSpots = [];
    List<FlSpot> inComeSpots = [];
    double cumulativeTotal = 0;
    double cumulativeIncome = 0;

    // 日付リストを作成
    List<String> incomedates = [];
    List<String> alldates = [];

    // 最初の点 (0, 0) を追加
    allSpots.add(FlSpot(0, 0));
    inComeSpots.add(FlSpot(0, 0));

    // 支出こみのグラフロジック
    for (var i = userData.length - 1; i >= 0; i--) {
      int priceChange = userData[i].deposit == false ? -userData[i].price : userData[i].price;
      cumulativeIncome += priceChange;
      allSpots.add(FlSpot((userData.length - i).toDouble(), cumulativeIncome));
      try {
        DateTime parsedDate;
        parsedDate = userData[i].dataTime;
        alldates.add(DateFormat('MM/dd').format(parsedDate)); // 表示用にフォーマット
      } catch (e) {
        alldates.add('Invalid date'); // エラーハンドリング
      }
    }
    int incomeIndex = 1; // 収入データ専用のインデックスを作成 0の場合はエラーが発生するため1からスタート

    // 支出を除いたグラフロジック
    for (var i = userData.length - 1; i >= 0; i--) {
      if (userData[i].deposit == true) {
        // 支出を除外し、収入データのみ処理する
        cumulativeTotal += userData[i].price;

        // 収入専用のインデックスを使って X 座標を設定
        inComeSpots.add(FlSpot(incomeIndex.toDouble(), cumulativeTotal));

        try {
          DateTime parsedDate = userData[i].dataTime;
          incomedates.add(DateFormat('MM/dd').format(parsedDate)); // 表示用にフォーマット
        } catch (e) {
          incomedates.add('Invalid date'); // エラーハンドリング
        }

        incomeIndex++; // 収入があるたびにインデックスを進める
      }
    }
    // LineChartDataをgraph_dataから呼び出す
    LineChartData allChartData = createLineChartData(allSpots, alldates);
    LineChartData inComeDates = createLineChartData(inComeSpots, incomedates);

    // userData の各要素に対して処理を行う
    for (var save in userData) {
      if (categoryData.containsKey(save.name)) {
        categoryData[save.name]!['totalPrice'] += save.price;
        categoryData[save.name]!['count'] += 1;
      } else {
        categoryData[save.name] = {
          'totalPrice': save.price,
          'count': 1,
        };
      }
    }

    // 現在の日付を取得
    String currentDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

    //　データがある場合は、最新の日付を取得
    String displayDateRange;
    if (userData.isNotEmpty) {
      displayDateRange = '${DateFormat('yyyy/MM/dd').format(userData[userData.length - 1].dataTime)} ~ $currentDate';
    } else {
      displayDateRange = 'データがありません'; // データがない場合
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayDateRange,   // 表示する日付の範囲
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  selectedOption == '全体' 
                    ? '¥ ${NumberFormat("#,###").format(allPrice[1])}'
                    : '¥ ${NumberFormat("#,###").format(allPrice[0])}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: '先週比：',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black,
                //         ),
                //       ),
                //       TextSpan(
                //         text: '￥521(9.4%)',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Color(0xFF00BB16),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ]
            ),
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 0,
                    left: 10,
                    top: 15,
                    bottom: 12,
                  ),
                  child:LineChart(
                    //animatedChart(allChartData, _chartanimation.value),
                    selectedOption == '全体'
                    ? animatedChart(allChartData, _chartanimation.value)
                    : animatedChart(inComeDates, _chartanimation.value)
                  )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
               ChoiceChip(
                label: Text('ついで収入'), 
                selected: selectedOption == 'ついで収入',
                onSelected: (bool selected) {
                  setState(() {
                    selectedOption = 'ついで収入';
                  });
                },
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: selectedOption == 'ついで収入' ? Colors.white : Colors.black,
                ),
                checkmarkColor: selectedOption == 'ついで収入' ? Colors.white : Colors.black,
                chipAnimationStyle: ChipAnimationStyle(
                  avatarDrawerAnimation: AnimationStyle(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 15,
                    cornerSmoothing: 0.5,)
                ),
               ),
              const SizedBox(width: 40),
              ChoiceChip(
                label: Text('全体'), 
                selected: selectedOption == '全体',
                onSelected: (bool selected) {
                  setState(() {
                    selectedOption = '全体';
                  });
                },
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: selectedOption == '全体' ? Colors.white : Colors.black,
                ),
                checkmarkColor: selectedOption == '全体' ? Colors.white : Colors.black,
                chipAnimationStyle: ChipAnimationStyle(
                  avatarDrawerAnimation: AnimationStyle(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 15,
                    cornerSmoothing: 0.5,)
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'カテゴリー別のついで記録',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,  
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 2.0, 
                  children: [
                    // 飲み物のデータを表示
                    _buildGridItem(
                      Icons.local_drink, 
                      Color(0xff007AFF),
                      '${categoryData['飲み物']?['count'] ?? 0}回', 
                      '¥${NumberFormat("#,###").format(categoryData['飲み物']?['totalPrice'] ?? 0)}'
                    ),
                    // 食事のデータを表示
                    _buildGridItem(
                      Icons.fastfood, 
                      Color(0xffFF9500), 
                      '${categoryData['食事']?['count'] ?? 0}回', 
                      '¥${NumberFormat("#,###").format(categoryData['食事']?['totalPrice'] ?? 0)}'
                    ),
                    // 菓子類のデータを表示
                    _buildGridItem(
                      Icons.icecream, 
                      Color(0xff34C759),
                      '${categoryData['菓子類']?['count'] ?? 0}回', 
                      '¥${NumberFormat("#,###").format(categoryData['菓子類']?['totalPrice'] ?? 0)}'
                    ),
                    // その他のデータを表示
                    _buildGridItem(
                      Icons.star, 
                      Color(0xffFF2D55), 
                      '${categoryData['その他']?['count'] ?? 0}回', 
                      '¥${NumberFormat("#,###").format(categoryData['その他']?['totalPrice'] ?? 0)}'
                    ),
                  ],
                ),
              ]
            ),
          ),
        ]
      )
    );
  }

  LineChartData animatedChart(LineChartData data, double t){
    return LineChartData(
      borderData: data.borderData,
      titlesData: data.titlesData,
      gridData: data.gridData,
      minY: 0, 
      extraLinesData: ExtraLinesData(
      horizontalLines: [
        HorizontalLine(
          y: 0,  // 最小値を超える水平線を描画しないように設定
          color: Colors.transparent,
        ),
      ],
    ),
    lineBarsData: data.lineBarsData.map((barData) {
      final List<FlSpot> animatedSpots = [];
      // スポットの間をアニメーションで描画する
      for (int i = 0; i < barData.spots.length - 1; i++) {
        final currentSpot = barData.spots[i];
        final nextSpot = barData.spots[i + 1];

        // アニメーションの進行度合いに応じて線を伸ばす
        if (t >= (i + 1) / (barData.spots.length - 1)) {
          // 次のスポットまで完全に描画
          animatedSpots.add(currentSpot);
        } else if (t > i / (barData.spots.length - 1)) {
          // 部分的に描画
          final progress = (t - i / (barData.spots.length - 1)) * (barData.spots.length - 1);
          final double interpolatedX = currentSpot.x + (nextSpot.x - currentSpot.x) * progress;
          final double interpolatedY = currentSpot.y + (nextSpot.y - currentSpot.y) * progress;
          animatedSpots.add(currentSpot);
          animatedSpots.add(FlSpot(interpolatedX, interpolatedY));
          break;
        }
      }

      if (t == 1) {
        // アニメーションが完了したら、最後のスポットを追加
        animatedSpots.add(barData.spots.last);
      }
      return LineChartBarData(
        spots: animatedSpots,
        isCurved: barData.isCurved,
        curveSmoothness: barData.curveSmoothness,
        color: barData.color,
        barWidth: barData.barWidth,
        belowBarData: barData.belowBarData,
        dotData: barData.dotData,
      );
    }).toList(),
      lineTouchData: data.lineTouchData,
    );
  }
}

Widget _buildGridItem(IconData icon, Color color ,String count, String price,) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 30, color: color,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 3),
              Text(count, style: TextStyle(fontSize: 14, color: Colors.black87 ,fontWeight: FontWeight.bold)),
              Text(price, style: TextStyle(fontSize: 14, color: Colors.black87 ,fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(width: 0),
        ],
      ),
    ),
  );
}

Widget changeButtons(String period) {
  return ElevatedButton(
    onPressed: () {},
    style: period == '全体'
        ? ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // 背景を透明にする
          )
        : ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // 背景を透明にする
            shadowColor: Colors.transparent, // 影を透明にする
          ),
    child: Text(
      period,
      style: TextStyle(
        color: period == '全体' ? Colors.white : Colors.black, // '全体'の場合は白、他の場合は黒
      ),
    ),
  );
}





