import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';

//providers
import '/views/pages/calculator/providers/all_price.dart';
import "../providers/temporary_topic_list.dart";

class CustomForm extends ConsumerStatefulWidget {
  const CustomForm({super.key});

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  DateTime _selectedDate = DateTime.now(); // デフォルトで現在の日付
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final TextEditingController _priceController = TextEditingController(); //
  String _EnteredPrice = ''; // 入力された金額を保持する変数
  int _calculatedPrice = 6055; // 計算結果を保持する変数
  double _calculatedPercent = 0.0; // 計算結果を保持する変数

  @override
  void initState() {
    super.initState();

    // FocusNodeのリスナーを追加
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        Scrollable.ensureVisible(
          context,
          curve: Curves.easeInOut,
        );
      }
    });

    _focusNode3.addListener(() {
      if (_focusNode3.hasFocus) {
        Scrollable.ensureVisible(
          context,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _getEnteredPrice(allPraice) {
    setState(() {
      _EnteredPrice = _priceController.text; // 入力された金額を取得して変数に保存
      int enteredPriceInt = int.tryParse(_EnteredPrice) ?? 0; // 文字列を整数に変換、失敗したら0
      _calculatedPrice = allPraice - enteredPriceInt; // 6055から引いた金額を計算
      double calculatedPercent = (enteredPriceInt.toDouble() / 6055 * 100); // 割合を計算
      _calculatedPercent = double.parse(calculatedPercent.toStringAsFixed(1)); // 少数第1位に丸める
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _scrollController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temporaryTopicList = ref.read(temporaryTopicListNotifierProvider.notifier);
    final allPraice = ref.watch(allPriceNotifierProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // キーボードを閉じる
      },
      child: SingleChildScrollView(
        controller: _scrollController, // スクロールコントローラーを設定
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'タイトル',
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
                                : Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
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
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          temporaryTopicList.updateTitle(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // 金額入力フィールド
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '￥',
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
                        controller: _priceController,
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
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: '700',
                          border: InputBorder.none, // 下線を消す
                        ),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffE82929),
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus(); // フォーカスを外してキーボードを閉じる
                          _getEnteredPrice(allPraice); // 入力された金額を取得して処理する
                        },
                        onChanged: (value) {
                          int price = int.tryParse(value) ?? 0;
                          temporaryTopicList.updatePrice(price);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // 日付選択フィールド
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '日付',
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
                          minTime: DateTime.now().subtract(Duration(days: 30)), // 今日から30日前
                          maxTime: DateTime.now(),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            print('confirm $date');
                            temporaryTopicList.updateDate(date);
                            setState(() {
                              _selectedDate = date; // 日付を更新
                            });
                          },
                          currentTime: _selectedDate,
                          locale: LocaleType.jp, // 日本語に設定
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'メモ',
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
                        focusNode: _focusNode3, // フォーカスノードを設定
                        maxLines: null, // 行数を制限しない
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withOpacity(0.3)
                                : Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: '友達と食べた',
                          border: InputBorder.none, // 下線を消す
                        ),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          temporaryTopicList.updateMemo(value);
                        },
                      ),  
                    ),
                  ],
                ),
              ),
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
                    Text('¥${NumberFormat("#,###").format(allPraice)}',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(Icons.arrow_downward, size: 20, color: Colors.black),
                    Text('¥${NumberFormat("#,###").format(_calculatedPrice)}',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      ),
                    ),
                    Text('-¥${NumberFormat("#,###").format(int.tryParse(_EnteredPrice) ?? 0)} (-$_calculatedPercent%)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffE82929),
                      ),
                    ), 
                  ],  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}