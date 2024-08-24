import 'package:flutter/material.dart';

class DateInputField extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateChanged;

  DateInputField({this.initialDate, required this.onDateChanged});

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
    // 現在日時
  DateTime _date = new DateTime.now();

  @override
  void initState() {
    super.initState();
    // デフォルトの日付を設定。初期値がない場合は2024年1月1日に設定この部分はデータが格納された日付に変更する必要がある。
    _selectedDate = widget.initialDate ?? _date;
    _controller.text = "${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.year}";
  }
  // 日付選択
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: _selectedDate!, // 初期表示の日付
      firstDate: DateTime(2024), // 選択可能な最小の日付
      lastDate: DateTime(2101), // 選択可能な最大の日付
      
    );
    // 日付が選択された場合、日付を更新
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;// 選択された日付をセット
        _controller.text = "${_selectedDate!.year}/${_selectedDate!.month.toString().padLeft(2,)}/${_selectedDate!.day.toString().padLeft(2, '0')}";// 日付をテキストフィールドに表示
        widget.onDateChanged(_selectedDate); // 親ウィジェットに日付を通知
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: "日にち",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),// カレンダーアイコン
            onPressed: () => _selectDate(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        readOnly: true,// テキストフィールドを編集不可にする
        onTap: () => _selectDate(context),
      ),
    );
  }
}
