import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../graph/graph_data.dart';

import 'package:figma_squircle/figma_squircle.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> with SingleTickerProviderStateMixin {
  String selectedOption = '貯蓄額'; // 初期値
  AnimationController? _chartanimationController;
  Animation<double>? _chartanimation;

  @override
  void initState() {
    super.initState();
    _chartanimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _chartanimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartanimationController!, 
        curve: Curves.easeInOutCirc,)
    )
    ..addListener(() {
      setState(() {});
    });
    _chartanimationController?.forward();
  }

  @override
  void dispose() {
    _chartanimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'グラフ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2024/5/10 ~ 2024/8/15',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  selectedOption == '推移' 
                  ? '¥6,055'
                  : '¥12,500',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '先週比：',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '￥521(9.4%)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BB16),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    left: 0,
                    top: 15,
                    bottom: 12,
                  ),
                  child:LineChart(
                    selectedOption == '推移'
                    ? animatedChart(savedData(), _chartanimation!.value)
                    : animatedChart(allData(), _chartanimation!.value),
                  )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
               ChoiceChip(
                label: Text('貯蓄額'), 
                selected: selectedOption == '貯蓄額',
                onSelected: (bool selected) {
                  setState(() {
                    selectedOption = '貯蓄額';
                  });
                },
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: selectedOption == '貯蓄額' ? Colors.white : Colors.black,
                ),
                checkmarkColor: selectedOption == '貯蓄額' ? Colors.white : Colors.black,
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
                label: Text('推移'), 
                selected: selectedOption == '推移',
                onSelected: (bool selected) {
                  setState(() {
                    selectedOption = '推移';
                  });
                },
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: selectedOption == '推移' ? Colors.white : Colors.black,
                ),
                checkmarkColor: selectedOption == '推移' ? Colors.white : Colors.black,
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
                  'カテゴリー別の我慢',
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
                    _buildGridItem(Icons.local_drink, Colors.blue, '23回', '¥3,690' ),
                    _buildGridItem(Icons.fastfood, Colors.orange, '15回', '¥2,500'),
                    _buildGridItem(Icons.icecream, Colors.lightGreen,'8回', '¥1,540'),
                    _buildGridItem(Icons.star, Colors.green,'13回', '¥2,489'),
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
      lineBarsData: data.lineBarsData.map((barData) {
        return LineChartBarData(
          spots: barData.spots
              .sublist(0, (barData.spots.length * t).toInt()), // tに基づいてスポットを描画
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





