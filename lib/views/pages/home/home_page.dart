//package
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:iconoir_flutter/regular/box.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import 'package:pull_down_button/pull_down_button.dart';

//components
import 'components/money_history.dart';

//pages
//import '../calculator/calculator_page.dart';
import '../graph/graph_page.dart';
import '../setting/setting_page.dart';
import '../home/components/pay_dialog.dart';
import 'components/menu_ios.dart';
import 'components/category_graph.dart';

//commons
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';

//riverpods
import '../calculator/providers/all_price.dart';
import "./providers/user_log.dart";
import '../home/providers/show_dialog.dart';

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
            top: MediaQuery.of(context).size.height * 0.14,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'あなたのついで口座残高',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5B5B5B),
                    ),
                  ),
                  Text(
                    '¥ ${NumberFormat("#,###").format(allPrice[1])}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 50,
                  child: CategoryBarChart(),),
                ],
              ),
            )
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GraphPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'グラフを確認する',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue
                              ),
                            ),
                            Container(
                              height: 28,
                              alignment: Alignment.center,  
                              child: Icon(
                                Icons.chevron_right,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),    
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
