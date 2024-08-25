import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparator extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // カンマを除去してからフォーマット
    String text = newValue.text.replaceAll(',', '');
    if (text.isEmpty) {
      return newValue;
    }

    final formatter = NumberFormat('#,###');
    String formattedText = formatter.format(int.parse(text));

    // カーソルの位置を計算
    int selectionIndex = formattedText.length - (text.length - newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}