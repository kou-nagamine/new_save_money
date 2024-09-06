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
import '../home/components/pay_dialog.dart';

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
    // final showPopUp = ref.watch(showPopUpNotifierProvider); //ポップアップの表示
    print('$historyData');
    //log('showPopUp: $showPopUp');
    
    // if (showPopUp) {
    //   Future.delayed(Duration.zero, () {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return PayDialog(
        //     );
        //   },
        // ).then((_) {
        //   // ポップアップを閉じたらshowPopUpをfalseにリセット
        //   ref.read(showPopUpNotifierProvider.notifier).hide();
        // });
    //   });
    // }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0085FF), Color(0xFF0A2B4A)],
                begin: Alignment.topLeft,
                end: Alignment(0.9, -0.6),
                stops: [0.3, 1.0],
              ),
            ),
            constraints: const BoxConstraints.expand(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            right: 30,
            child: IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                size: 35,
                color: Colors.white,
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
            top: MediaQuery.of(context).size.height * 0.11,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¥ ${NumberFormat("#,###").format(allPrice[1])}',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '￥521(9.4%)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF1E),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.73,
              padding: EdgeInsets.fromLTRB(30, 15, 10, 100),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '履歴',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(allPriceNotifierProvider.notifier).resetPreferences();
                          ref.read(userLogNotifierProvider.notifier).resetLogs();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GraphPage()),
                          );
                          print(allPrice);
                        },
                        child: Row(
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
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: historyData.isEmpty
                      ? const Padding(
                        padding:  EdgeInsets.only(top: 50),
                        child: Text('我慢した金額を入力しよう！'))
                      : MoneyHistoryList(),
                    ),
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
