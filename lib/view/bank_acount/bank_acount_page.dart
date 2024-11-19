//package
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:iconoir_flutter/regular/box.dart';
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import 'package:flutter/services.dart';

//components
import 'components/log_types.dart';
//pages
//import '../calculator/calculator_page.dart';
import '../log_data.dart/log_date_page.dart';
import 'components/menu_type.dart';
import 'components/category_graph.dart';

//riverpods
import '../../view_model/all_price.dart';
import "../../view_model/user_log.dart";
import '../../view_model/log_type.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context , WidgetRef ref) { 
    final allPrice = ref.watch(allPriceNotifierProvider);
    final historyData = ref.watch(userLogNotifierProvider);//sharedPrefarence導入前監視用

    // デバイスの縦・横幅の取得
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: PopScope(
        canPop: false,
        child:Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE3EEFF), Color(0xFFFFFFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment(0.3, -0.2),
                    stops: [0.3, 0.8],
                  ),
                ),
                constraints: const BoxConstraints.expand(),
              ),
              Positioned(
                top: deviceHeight < 700 ? deviceHeight * 0.04 : deviceHeight * 0.08,
                right: deviceWidth * 0.07,  // 横幅調整
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: deviceHeight * 0.038, // 大きさ調整
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settingPage');
                  },
                ),
              ),
              Positioned(
                top: deviceHeight < 700 ? deviceHeight * 0.1 : deviceHeight * 0.13,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GraphPage()),
                    );
                  },
                  child:  Container(
                    width: deviceWidth * 1.0,
                    padding: EdgeInsets.fromLTRB(deviceWidth * 0.07, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'あなたの口座残高',
                          style: TextStyle(
                            fontSize: 13, 
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5B5B5B),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              allPrice[1] > 999999999 // ここで桁数をチェック
                                  ? '¥ 9,999,999+'
                                  : '¥ ${NumberFormat("#,###").format(allPrice[1])}', 
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: deviceWidth * 0.07),
                              height: 26, // 高さ調整
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '詳細',
                                    style: TextStyle(
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 30, 
                                    color: Colors.blue,
                                  ),
                                ],
                              )
                            )
                          ]
                        ),
                        SizedBox(height: deviceHeight * 0.011), // 高さ調整
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '今までのついで合計額 ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5B5B5B),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '¥${NumberFormat("#,###").format(allPrice[0])}',
                                    style: TextStyle(
                                      fontSize: 18,  
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: deviceHeight * 0.005), //　高さ調整
                        SizedBox(
                          height: 50, 
                          child: CategoryBarChart(),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: deviceWidth * 1.0,
                  height: deviceHeight < 700 ? deviceHeight * 0.65 : deviceHeight * 0.68,
                  padding: EdgeInsets.fromLTRB(deviceWidth * 0.058, deviceHeight * 0.006, deviceWidth * 0.058, deviceHeight * 0.107), // 調整
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline, // ベースラインに揃える
                        textBaseline: TextBaseline.alphabetic, // テキストのベースラインを使う
                        children: [
                          Text(
                            '履歴',
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          PaymentMenu(),
                        ],
                      ),
                      Expanded(
                        child: historyData.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.054), // 
                            child: Text('ついで出費を記録しよう！'),
                          )
                        : Consumer(
                            builder: (context, ref, _) {
                              // AsyncValue<List<bool>>のデータを取得
                              final selectType = ref.watch(logTypeNotifierProvider);

                              return selectType.when(
                                data: (types) {
                                  // データが正常に取得された場合
                                  if (types[0] == true) {
                                    return MoneyHistoryList(); // 全体
                                  } else if (types[1] == true) {
                                    return DepositList(); // ついで収入
                                  } else if (types[2] == true) {
                                    return ExpencesList(); // 支出
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.only(top: deviceHeight * 0.054),
                                      child: Text('ついで出費を記録しよう！'),
                                    );
                                  }
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(), // データがロード中の場合
                                ),
                                error: (error, stack) => Center(
                                  child: Text('エラーが発生しました: $error'), // エラーが発生した場合
                                ),
                              );
                            },
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
