import 'package:flutter/material.dart';

// components
import 'components/dateInput_field.dart';
import 'components/memo_field.dart';
import 'components/items_card.dart';


class ReferencePage extends StatefulWidget {
  @override
  _ReferencePageState createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  String _memo = '水筒を持参した分';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // キーボードを閉じる
        },
        child: Stack(
          children: [
            Positioned(
              top:0,
              child: ItemsCard()),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // 前のページに戻る
                },
                icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Colors.black,
                  size: 50,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
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
                    Text(
                      '¥100',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2CB13C)),
                    ),
                    DateInputField(
                      initialDate: _selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                    MemoField(
                      initialMemo: _memo,
                      onMemoChanged: (value) {
                        setState(() {
                          _memo = value.isEmpty ? '水筒を持参した分' : value;
                        });
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('日付: ${_selectedDate}');// デフォルトを2024年1月1日に設定。個々の値はデータが格納された日付にする予定
                          print('メモ: $_memo');
                        },
                        child: Text(
                          '完了',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
