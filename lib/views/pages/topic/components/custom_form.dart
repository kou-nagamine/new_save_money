import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';


class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  DateTime _selectedDate = DateTime.now();  // デフォルトで現在の日付
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();

    // FocusNode1のリスナーを追加
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    // FocusNode2のリスナーを追加
    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        Scrollable.ensureVisible(
          context,
          curve: Curves.easeInOut,
        );
      }
    });

    // FocusNode3のリスナーを追加
    _focusNode3.addListener(() {
      if (_focusNode3.hasFocus) {
        Scrollable.ensureVisible(
          context,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // ウィジェットが破棄される際にフォーカスノードも破棄
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       controller: _scrollController, // スクロールコントローラーを設定
      child:  Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                      focusNode: _focusNode1, // フォーカスノードを設定
                      textAlign: TextAlign.end, // テキストを右揃えにする
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.3)
                              : Colors.black.withOpacity(0.3)
                        ),
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
                      //keyboardType: TextInputType.number,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // 数字のみ入力可能にする
                      ],
                      focusNode: _focusNode2, // フォーカスノードを設定
                      textAlign: TextAlign.end, // テキストを右揃えにする
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.3)
                              : Colors.black.withOpacity(0.3)
                        ),
                        hintText: '700',
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
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Color(0xff5B5B5B),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now().subtract(Duration(days: 30)),  // 今日から30日前
                            maxTime: DateTime.now(), 
                            onChanged: (date) {
                              print('change $date');
                            },
                            onConfirm: (date) {
                              print('confirm $date');
                              setState(() {
                                _selectedDate = date;  // 日付を更新
                              });
                            },
                            currentTime: _selectedDate,
                            locale: LocaleType.jp,  // 日本語に設定
                          );
                        },
                        child: Text(
                          '${_selectedDate.year}年${_selectedDate.month}月${_selectedDate.day}日',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                            ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 左揃えに設定
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
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(8.0), // 角を丸くする
                      //   border: Border.all(
                      //     color: Theme.of(context).brightness == Brightness.dark
                      //         ? Colors.white
                      //         : Colors.black, // 枠線の色
                      //     width: 2.0, // 枠線の太さ
                      //   ),
                      // ),
                      child: TextField(
                        focusNode: _focusNode3, // フォーカスノードを設定
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
          ],
        )
      )
    );
  }
}

