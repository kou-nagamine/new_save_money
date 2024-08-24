import 'package:flutter/material.dart';

import 'package:new_save_money/views/pages/reference/components/dateInput_field.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('タイトル',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff5B5B5B),
                  ),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.end, // テキストを右揃えにする
                    decoration: InputDecoration(
                      hintText: 'サークルの会食', 
                      border: InputBorder.none, // 下線を消す
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    textInputAction: TextInputAction.done, // キーボードに「完了」ボタンを表示
                    onSubmitted: (_) {
                      // キーボードの「完了」を押した時の処理
                      FocusScope.of(context).unfocus(); // フォーカスを外してキーボードを閉じる
                    },
                  ),
                ),
              ],
            ),
          ),
           Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('金額',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff5B5B5B),
                  ),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.end, // テキストを右揃えにする
                    decoration: InputDecoration(
                      border: InputBorder.none, // 下線を消す
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE82929)
                    ),
                    textInputAction: TextInputAction.done, // キーボードに「完了」ボタンを表示
                    onSubmitted: (_) {
                      // キーボードの「完了」を押した時の処理
                      FocusScope.of(context).unfocus(); // フォーカスを外してキーボードを閉じる
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('日付',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff5B5B5B),
                  ),
                ),
                // Expanded(
                // ),
              ],
            ),
          ),
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('メモ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xff5B5B5B),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0), // ボックスの内側にパディングを追加
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // 角を丸くする
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black, // 枠線の色
                        width: 2.0, // 枠線の太さ
                      ),
                    ),
                    child: TextField(
                      maxLines: null, // テキストフィールド内で複数行に対応
                      textAlignVertical: TextAlignVertical.top, // テキストをボックス内の上部に揃える
                      decoration: InputDecoration(
                        hintText: '', 
                        border: InputBorder.none, // デフォルトの下線を消す
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      textInputAction: TextInputAction.done, // キーボードに「完了」ボタンを表示
                      onSubmitted: (_) {
                        // キーボードの「完了」を押した時の処理
                        FocusScope.of(context).unfocus(); // フォーカスを外してキーボードを閉じる
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
          //   child:  TextField(
          //     controller: _memoController,
          //     decoration: InputDecoration(
          //       labelText: 'メモ',
          //       hintText: 'サークルメンバーとの会食',
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: Container(
          //     margin: EdgeInsets.only(top: 0),
          //     width: double.infinity,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         print('日付: $_selectedDate');
          //         print('メモ: ${_controller.text}');
          //       },
          //       child: Text(
          //         '完了',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         elevation: 0,
          //         padding: EdgeInsets.only(top: 15, bottom: 15),
          //         backgroundColor: Colors.blue,
          //       ),
          //     ),
          //   ),
          // )
        ],
      )
    );
  }
}

