import 'package:flutter/material.dart';
import "./components/record_card.dart";
import "./components/custom-header.dart";
import "./components/item.dart";
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight / 3;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(title: 'あなたについて'),
          RecordCard(),
          Container(
        height: containerHeight,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '設定',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications_active,
                ),
                Text(
                  '通知をON',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SwitchItem(),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.stay_primary_portrait,
                ),
                Text(
                  '入出金をデフォルトにする',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SwitchItem(),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.info,
                ),
                Text(
                  'このアプリについて',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.send,
                ),
                Text(
                  'フィードバックをおくる',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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