import 'package:flutter/material.dart';

class MemoField extends StatelessWidget {
  final String initialMemo;

  MemoField({required this.initialMemo});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 1, 
      padding: EdgeInsets.all(10), // ボックスの内側にパディングを追加
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // 角を丸くする
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Color(0xffC5C5C5), // 枠線の色
        width: 1.0, // 枠線の太さ
        ),
      ),
      child: Text(
        initialMemo,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      )
    );
  }
}
