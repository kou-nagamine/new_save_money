//package
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:iconoir_flutter/regular/box.dart';

//components
import 'components/money_history.dart';

//pages
//import '../calculator/calculator_page.dart';
import '../graph/graph_page.dart';
import '../setting/setting_page.dart';

//commons
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';

//riverpods
import '../calculator/providers/all_price.dart';
import "./providers/user_log.dart";

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final allPrice = ref.watch(allPriceNotifierProvider);
    final historyData = ref.watch(userLogNotifierProvider);
    print('$historyData');
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
                color: Colors.white70,
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
                  '￥${allPrice}',
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
              padding: EdgeInsets.all(40),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '履歴',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.insights, size: 30),  // アイコンを設定
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GraphPage()),
                          );
                          print(allPrice);
                        }
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: MoneyHistoryList(
                      historyData: historyData,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
