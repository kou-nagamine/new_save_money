//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "components/record_card.dart";
import "components/switch_item.dart";
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../commons/components/danger_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:new_save_money/view/walkthrough/pageview.dart';

import 'package:new_save_money/view_model/user_log.dart';
import 'package:new_save_money/view_model/all_price.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';


import 'package:new_save_money/view/walkthrough/pageview.dart';

//MaterialWithModalsPageRoute
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//URLランチャー
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
   ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  bool isNotificationOn = false; // 通知用のスイッチの初期値
  bool isDefaultTransaction = false; // 入出金用のスイッチの初期値
  bool isLight = true;

  // URLを開く関数
  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSwitchValues(); // SharedPreferencesから値をロード
  }

  // SharedPreferencesからスイッチの状態を読み込む
  Future<void> _loadSwitchValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotificationOn = prefs.getBool('NotificationSwitch') ?? false; // 通知スイッチのデフォルトはfalse
      isDefaultTransaction = prefs.getBool('DefaultTransactionSwitch') ?? false; // 入出金スイッチのデフォルトはfalse
    });
  }

  // SharedPreferencesにスイッチの状態を保存
  Future<void> _saveSwitchValue(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    //final containerHeight = screenHeight / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text('あなたについて',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecordCard(),
            Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   '設定',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 10), // タイトルと最初の項目の間に余白を追加
                // Container(
                //   height: 50,
                //   child:  Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           iconoir.BellNotification(
                //             width: 25,
                //             color: Theme.of(context).brightness == Brightness.dark
                //               ? Colors.white
                //               : Colors.grey[500],
                //           ),
                //           Padding(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   '通知をONにする',
                //                   style: TextStyle(
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.grey[500]
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             padding: EdgeInsets.only(left: 20),
                //           ),
                //         ],
                //       ),
                //       //通知機能が実装されるまで無効化
                //       SwitchItem(
                //         value: isNotificationOn,
                //         onChanged: (bool value) {
                //           setState(() {
                //             isNotificationOn = value;
                //           });
                //           _saveSwitchValue('NotificationSwitch', value); // 通知スイッチの状態を保存
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  height: 50,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          iconoir.SmartphoneDevice(
                            width: 25,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          ),
                          Padding(child: Text(
                            '起動時についでを表示する',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ) , 
                          padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                      SwitchItem(
                        value: isDefaultTransaction,
                        onChanged: (bool value) {
                          setState(() {
                            isDefaultTransaction = value;
                          });
                          _saveSwitchValue('DefaultTransactionSwitch', value); // 入出金スイッチの状態を保存
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child:  InkWell(
                    onTap: () async{
                      // モーダル表示前に文字色変更
                      setState(() {
                        isLight = !isLight;
                      });
                      await showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      //backgroundColor: Colors.transparent,
                      builder: (context) => PageViewWidget(isFromSettings: true), 
                      );
                      setState(() {
                        isLight = !isLight;
                      });
                    },
                    child: Row(
                      children: [
                        iconoir.InfoCircle(
                          width: 25,
                          color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        ),
                        Padding(
                          child: Text('このアプリについて',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,),
                        ) , 
                        padding: EdgeInsets.only(left: 20)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: InkWell( 
                     onTap: () => _launchURL('https://testflight.apple.com/v1/app/6727008177?build=151121270'), // リンクに飛ばす
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconoir.SendDiagonal(
                          width: 25,
                          color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        ),
                        Padding(
                          child: Text('フィードバックをおくる',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ) , 
                        padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                   ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Danger Zone',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5B5B5B),
                    ),
                  ),
                  Container(
                  height: 50,
                  child: InkWell( 
                     onTap: () {
                      DefaultCacheManager().emptyCache();
                      // キャッシュがクリアされたことをユーザーに通知
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('全てのキャッシュをクリアしました')),
                      );
                     }, // リンクに飛ばす
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconoir.Trash(
                          width: 25,
                          color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        ),
                        Padding(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('キャッシュを削除する',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('この動作によってデータが消えることはありません。',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ) ,
                        padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                   ),
                  ),
                  Container(
                  height: 50,
                  child: InkWell( 
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => DangerDialog(
                        onConfirm: () async {
                          // 設定ページ用の削除処理
                          try {
                            ref.read(userLogNotifierProvider.notifier).resetLogs();
                            ref.read(allPriceNotifierProvider.notifier).resetPreferences();
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('tutorial');
                            await prefs.remove('DefaultTransactionSwitch');
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageViewWidget(),
                                ),
                              );
                            }
                          } catch (e) {
                            // エラーハンドリング
                            print('Error: $e');
                          }
                        },
                      ),
                    ),
                    child:  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconoir.WarningTriangleSolid(
                          width: 25,
                          color: Color(0xffd1242f),
                        ),
                        Padding(
                          child: Text('すべてのデータを削除する',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xffd1242f),
                          ),
                        ) , 
                        padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Version 0.1.2(241001)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5B5B5B),
                      ),
                    ),
                  )
                ],
              ),
            ),  
         ],
        ),
      ),
    );
  }
}