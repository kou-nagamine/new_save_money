//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "./components/record_card.dart";
import "components/custom_header.dart";
import "components/switch_item.dart";
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

//MaterialWithModalsPageRoute
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//URLランチャー
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

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
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    //final containerHeight = screenHeight / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text('あなたについて',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecordCard(),
            Container(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   CustomHeader(title: 'あなたについて'),
          //   RecordCard(),
          //   Container(
          // height: containerHeight,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '設定',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // タイトルと最初の項目の間に余白を追加
                Container(
                  height: 56,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          iconoir.BellNotification(
                            width: 20,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          ),
                          Padding(child: Text(
                              '通知をONにする',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ) , padding: EdgeInsets.only(left: 20),
                          ),
                        ],
                      ),
                      SwitchItem(),
                    ],
                  ),
                ),
                Container(
                  height: 56,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          iconoir.SmartphoneDevice(
                            width: 20,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          ),
                          Padding(child: Text(
                            '入出金をデフォルトにする',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ) , 
                          padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                      SwitchItem(),
                    ],
                  ),
                ),
                Container(
                  height: 56,
                  child:  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body:Builder(
                            builder: (context) => CupertinoPageScaffold(
                              child: Center(
                                child: Text('プライバシーポリシー'),
                              ),
                            ),  
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        iconoir.InfoCircle(
                          width: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        ),
                        Padding(
                          child: Text('このアプリについて',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                        ) , 
                        padding: EdgeInsets.only(left: 20)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  child: InkWell( 
                     onTap: () => _launchURL('https://flutter.dev/'), // リンクに飛ばす
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconoir.SendDiagonal(
                          width: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        ),
                        Padding(
                          child: Text('フィードバックをおくる',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ) , 
                        padding: EdgeInsets.only(left: 20)),
                        ],
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