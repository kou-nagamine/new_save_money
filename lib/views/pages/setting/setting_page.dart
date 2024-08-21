//packages
import 'package:flutter/material.dart';
import "./components/record_card.dart";
import "./components/custom-header.dart";
import "components/switch-item.dart";
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '設定',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        iconoir.BellNotification(),
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        iconoir.SmartphoneDevice(),
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
                Spacer(),
                Row(
                  children: [
                    iconoir.InfoCircle(),
                    Padding(
                      child: Text('このアプリについて',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
                    ) , 
                    padding: EdgeInsets.only(left: 20)),
                  ],
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    iconoir.SendDiagonal(),
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
                ],
              ),
            ),  
          ],
        ),
      ),
    );
  }
}