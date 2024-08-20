import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'グラフ',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  '¥6,055',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '先週比 : ¥521(+9.4%)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 2.0,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child:LineChart(
                LineChartData(
                  borderData: FlBorderData(
                    border: const Border(
                      top: BorderSide(color: Colors.grey),
                      right: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide(color: Colors.grey),
                    )
                  ),
                  titlesData: const FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: leftTitleWidgets,
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  //grid
                  gridData: const FlGridData(
                    show:false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots:const [
                        FlSpot(0,0),
                        FlSpot(1,2),
                        FlSpot(2,1),
                        FlSpot(3,4),
                        FlSpot(4,5),
                        FlSpot(5,2),
                        FlSpot(6,5),
                      ],
                      //color: Colors.red,
                      gradient: const LinearGradient(
                        colors:[
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      barWidth: 5,
                      isCurved: true,
                      curveSmoothness: 0.35,
                      dotData: const FlDotData(
                        show: true,
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                  )
                ),
              )
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              changeButtons('7日'),
              const SizedBox(width: 25),
              changeButtons('１ヶ月'),
              const SizedBox(width: 25),
              changeButtons('全体')
            ],
          )
        ],
      )
      
    );
  }
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

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('MAR', style: style);
      break;
    case 5:
      text = const Text('JUN', style: style);
      break;
    case 8:
      text = const Text('SEP', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }
  return Text(text, style: style, textAlign: TextAlign.left);
}


