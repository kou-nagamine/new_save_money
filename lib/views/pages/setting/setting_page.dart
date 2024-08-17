import 'package:flutter/material.dart';
import "./components/record_card.dart";
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
      child: Column(
        children: [
          RecordCard(),
        ],
      ),
    ),
    );
  }
}