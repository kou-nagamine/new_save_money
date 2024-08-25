import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final TextEditingController _priceController = TextEditingController(); //
  String _EnteredPrice = '';  // 入力された金額を保持する変数
  int _calculatedPrice = 0;  // 計算結果を保持する変数
  double _calculatedPercent = 0.0;  // 計算結果を保持する変数

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
  void _getEnteredPrice() {
    setState(() {
      _EnteredPrice = _priceController.text;  // 入力された金額を取得して変数に保存
      int enteredPriceInt = int.tryParse(_EnteredPrice) ?? 0;  // 文字列を整数に変換、失敗したら0
      _calculatedPrice = 6055 - enteredPriceInt;  // 6055から引いた金額を計算
      double calculatedPercent = (enteredPriceInt.toDouble() / 6055 * 100);  // 割合を計算
        _calculatedPercent = double.parse(calculatedPercent.toStringAsFixed(1));  // 少数第1位に丸める
    });
  }


  @override
  void dispose() {
    // ウィジェットが破棄される際にフォーカスノードも破棄
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _scrollController.dispose();
    _priceController.dispose();
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
              height: 50,
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
                            fontFamily: 'NotoSansJP',
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
              height: 50,
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
                      controller:  _priceController,
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
                              : Colors.black.withOpacity(0.3),
                              fontFamily: 'NotoSansJP',
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
                         _getEnteredPrice(); // 入力された金額を取得して処理する
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
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
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                    fontFamily: 'NotoSansJP',
                        ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 110,
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
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // ボックスの内側にパディングを追加
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // 角を丸くする
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xffC5C5C5), // 枠線の色
                          width: 1.0, // 枠線の太さ
                        ),
                      ),
                      child: TextField(
                        focusNode: _focusNode3, // フォーカスノードを設定
                        maxLines: null, // テキストフィールド内で複数行に対応
                        textAlignVertical: TextAlignVertical.top, // テキストをボックス内の上部に揃える
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.3)
                              : Colors.black.withOpacity(0.3),
                              fontFamily: 'NotoSansJP',
                        ),
                          hintText: 'メモをつける',
                          border: InputBorder.none, // デフォルトの下線を消す
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black87,
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
            SizedBox(height: 20),
            Container(
              height: 300,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('割り当て後の合計金額',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('¥6055',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                    ),
                  ),
                  Icon(Icons.arrow_downward, size: 20, color: Colors.black),
                  Text('¥$_calculatedPrice',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    ),
                  ),
                  Text('¥$_EnteredPrice (-$_calculatedPercent%)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xffE82929),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

