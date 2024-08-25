import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThousandsSeparator extends StatefulWidget {
  final TextEditingController controller; // テキストフィールドのコントローラー
  final FocusNode focusNode; // フォーカスノード
  final InputDecoration decoration; 
  final TextStyle style; 
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function(String) onSubmitted; // 入力完了時のコールバック
  final String hintText; // ヒントテキスト


  const ThousandsSeparator({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.decoration = const InputDecoration(),
    this.style = const TextStyle(),
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.done,
    required this.onSubmitted,
    this.hintText = '',
  }) : super(key: key);

  @override
  _ThousandsSeparator createState() => _ThousandsSeparator();
}

// テキストフィールドの入力値にカンマを追加する
class _ThousandsSeparator extends State<ThousandsSeparator> {
 @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final String text = widget.controller.text.replaceAll(',', ''); // カンマを除去
      if (text.isNotEmpty) {
        final formattedText = NumberFormat('#,###').format(int.parse(text));
        // カーソルの位置を保持するためにTextFieldを更新
        widget.controller.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    });
  }

 @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      decoration: widget.decoration,
      style: widget.style,
      textAlign: widget.textAlign,
      textInputAction: widget.textInputAction,
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value); // 入力が完了した際にコールバックを呼び出す
        }
      },
    );
  }
}