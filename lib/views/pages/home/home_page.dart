//package
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:iconoir_flutter/regular/box.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート

//components
import 'components/money_history.dart';

//pages
//import '../calculator/calculator_page.dart';
import '../graph/graph_page.dart';
import '../setting/setting_page.dart';
import 'components/menu_ios.dart';
import 'components/category_graph.dart';

//commons
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';

//riverpods
import '../calculator/providers/all_price.dart';
import "./providers/user_log.dart";

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final allPrice = ref.watch(allPriceNotifierProvider);
    final historyData = ref.watch(userLogNotifierProvider);//sharedPrefarence導入前監視用
    return Scaffold(
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
            top: MediaQuery.of(context).size.height * 0.08,
            right: 30,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GraphPage()),
                );
              },
              child:  Container(
                width: MediaQuery.of(context).size.width * 1.0,
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'あなたのついで残高',
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
                          '¥ ${NumberFormat("#,###").format(allPrice[1])}',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        //SizedBox(width: 50),
                        Container(
                          padding: EdgeInsets.only(right: 30),
                          height: 30,
                          child: Row(
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
                                size: 40,
                                color: Colors.blue,
                              ),
                            ],
                          )
                        )
                      ]
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'これまでの累計ついで額   ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5B5B5B),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '¥${NumberFormat("#,###").format(allPrice[0])}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    SizedBox(height: 50,
                    child: CategoryBarChart(),),
                  ],
                ),
              )
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.fromLTRB(25, 15, 25, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline, // ベースラインに揃える
                    textBaseline: TextBaseline.alphabetic, // テキストのベースラインを使う
                    children: [
                      const Text(
                        '履歴',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PaymentMenu(),
                      Spacer(),
                    ],
                  ),
                  Expanded(
                    child: historyData.isEmpty
                    ? const Padding(
                      padding:  EdgeInsets.only(top: 50),
                      child: Text('ついで出費を記録しよう！'))
                    : MoneyHistoryList(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
