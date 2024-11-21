import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

//providers
import '../../../view_model/all_price.dart';
import "../../../view_model/temporary_topic_list.dart";

// ひらがな漢字対応文字制限用Formatter
class LengthLimitingUnicodeTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  LengthLimitingUnicodeTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 入力された文字列の長さがmaxLengthを超えた場合、文字を切り捨てる
    if (newValue.text.characters.length > maxLength) {
      final truncated = newValue.text.characters.take(maxLength).toString();
      return TextEditingValue(
        text: truncated,
        selection: TextSelection.collapsed(offset: truncated.length),
      );
    }
    return newValue;
  }
}

class CustomForm extends ConsumerStatefulWidget {
  final String hinttitle;

  const CustomForm({
    super.key,
    required this.hinttitle
    });


  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends ConsumerState<CustomForm> {
  DateTime _selectedDate = DateTime.now(); // デフォルトで現在の日付
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final TextEditingController _priceController = TextEditingController(); 
  final TextEditingController _memoController = TextEditingController(); 
  final TextEditingController _titleController = TextEditingController(); 
  



  int calculatedPrice = 0;
  String _EnteredPrice = ''; // 入力された金額を保持する変数
  double _calculatedPercent = 0.0; // 計算結果を保持する変数

  // エラーメッセージを保持する変数
  String? _memoErrorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final allPrice = ref.read(allPriceNotifierProvider);
      setState(() {
        calculatedPrice = allPrice[1];
      });
    });

    // テキストフィールドを選択したときにスクロールする
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

  // 
  void _getEnteredPrice(allPrice) {
    setState(() {
      _EnteredPrice = _priceController.text; // 入力された金額を取得して変数に保存
      int enteredPriceInt = int.tryParse(_EnteredPrice) ?? 0; // 文字列を整数に変換、失敗したら0
      //　残高表示用
      calculatedPrice = allPrice[1] - enteredPriceInt;
      if (calculatedPrice < 0) {
        calculatedPrice = 0; // 0未満の場合は0にする
      }
      //割合表示用
      double calculatedPercent = (allPrice[1] / enteredPriceInt.toDouble() * 100); //　所持金/入力金額 = 割り当て率
      _calculatedPercent = double.parse(calculatedPercent.toStringAsFixed(1)); // 少数第1位に丸める
      if (_calculatedPercent > 100) {
        _calculatedPercent = 100; // 100%を超えた場合は100%にする
      }
    });
  }
  
  //タイトルの値が0または15以外のときはupdateTitleValidateはtrue
  void _validateTitle(String value) {
    final temporaryTopicList = ref.read(temporaryTopicListNotifierProvider.notifier);
    setState(() {
      if(value.length == 0 || value.isEmpty) {
        temporaryTopicList.updateTitleValidate(false);
      }
      else if (value.length >= 11) {
        temporaryTopicList.updateTitleValidate(false);
        showSnackBar(
          context: context,
          message: 'これ以上は入力できません',
        );
      }
      else {
        temporaryTopicList.updateTitleValidate(true);
      }
    });
  }
  
  //金額のバリデーション
  void _validatePrice(String value) {
    final temporaryTopicList = ref.read(temporaryTopicListNotifierProvider.notifier);
    setState(() {
      if (value.length == 0 || value.isEmpty || int.parse(value) == 0) {
        temporaryTopicList.updatePriceValidate(false);
      } else if (value.length >= 7){
        temporaryTopicList.updatePriceValidate(false);
        showSnackBar(
          context: context,
          message: 'これ以上は入力できません',
        );
      }else {
        temporaryTopicList.updatePriceValidate(true);
      }
    });
  }

  void showSnackBar({
  required BuildContext context,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlay = Overlay.of(context);
  

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 70,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          direction: DismissDirection.up,
          onDismissed: (direction) {
            // スナックバーを削除する処理
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
          key: ValueKey(message),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0xffFF3B30),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  
  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    // スナックバーを安全に削除
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}

  //メモのバリデーション
  void _validateMemo(String value) {
    final temporaryTopicList = ref.read(temporaryTopicListNotifierProvider.notifier);
    setState(() {
      if (value.length > 30) {
        _memoErrorMessage = 'メモは30文字以内で入力してください';
        temporaryTopicList.updateMemoValidate(false);
      } else {
        _memoErrorMessage = null;
        temporaryTopicList.updateMemoValidate(true);
      }
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _scrollController.dispose();
    _priceController.dispose();
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temporaryTopicList = ref.read(temporaryTopicListNotifierProvider.notifier);
    final allPrice = ref.watch(allPriceNotifierProvider);
    final Size size = MediaQuery.of(context).size;

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
              SizedBox(height: 15),
              // タイトル入力フィールド
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '支出の用途',
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
                        cursorColor: Colors.black,
                        controller: _titleController,
                        focusNode: _focusNode1, // フォーカスノードを設定
                        textAlign: TextAlign.end, // テキストを右揃えにする
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withOpacity(0.3)
                                : Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: widget.hinttitle,
                          border: InputBorder.none, // 下線を消す
                          // errorText: _titleErrorMessage, // エラーメッセージ
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingUnicodeTextInputFormatter(15), // ひらがな・漢字を含めて文字数を15文字に制限
                        ],
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          _validateTitle(value); // タイトル文字数をチェック
                          temporaryTopicList.updateTitle(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${_titleController.text.length}/10', // タイトルの長さを表示
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _titleController.text.length == 0
                          ? Colors.grey // 0文字の時はグレー
                          : _titleController.text.length <= 10
                              ? Colors.black // 1文字以上10文字以内は黒
                              : Colors.red, // 11文字以上は赤
                    ),
                  ),
                ]    
              ),
              SizedBox(height: 5),
              // 金額入力フィールド
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '値段',
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
                        cursorColor: Colors.black,
                        controller: _priceController,
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // 数字のみ入力可能にする
                          LengthLimitingTextInputFormatter(7),
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
                          hintText: '5000',
                          border: InputBorder.none, // 下線を消す
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffE82929),
                        ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus(); // フォーカスを外してキーボードを閉じる
                        },
                        onChanged: (value) {
                          _validatePrice(value);// 金額の文字数をチェック
                          _getEnteredPrice(allPrice); // 入力された金額を取得して処理する
                          int price = int.tryParse(value) ?? 0;
                          temporaryTopicList.updatePrice(price);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              (int.tryParse(_EnteredPrice) ?? 0) > allPrice[1]
                ? Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xffF5F5F5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child:  
                    allPrice[1] != 0 
                       ? 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.report, 
                                  color: Color(0xffFF9500),
                                  size: 15,),
                                Text(
                                  '全額割り当てる残高がありません。'
                                  ,style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFF9500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '¥${NumberFormat("#,###").format(allPrice[1])} ($_calculatedPercent%)',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffE82929),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'ついで収入から支払う',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff5B5B5B),
                                        ),
                                      ),
                                    ]
                                  )
                                )
                              ],
                            ),
                         ],
                       )
                       : Center(
                         child: Text(
                           '残高がありません',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                             color: Color(0xffE82929),
                           ),
                         ),
                       )
                     ),
                  )
                : Container(),
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
              // メモ入力フィールド
              Container(
                height: size.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5), // ボックスの内側にパディングを追加
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
                          cursorColor: Colors.black,
                          controller: _memoController,
                          focusNode: _focusNode3, // フォーカスノードを設定
                          maxLines: null, // 行数を制限しない
                          textAlignVertical: TextAlignVertical.top, // テキストをボックス内の上部に揃える
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintStyle: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: 'メモをつける',
                            border: InputBorder.none, // 下線を消す
                            errorText: _memoErrorMessage, // エラーメッセージ
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          style: TextStyle(
                            fontSize: 14,
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
                            _validateMemo(value); // メモの文字数をチェック
                            temporaryTopicList.updateMemo(value);
                          },
                        ),  
                      ),
                    )
                  ]
                ),
              ),
              Container(
                height: size.height * 0.4,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('支出後の合計金額',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('¥${NumberFormat("#,###").format(allPrice[1])}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                    Lottie.asset('assets/animations/arrow.json',
                      width: size.height * 0.1,
                      height: size.height * 0.1,
                      fit: BoxFit.cover,
                    ),
                    Text('¥${NumberFormat("#,###").format(calculatedPrice)}',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
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