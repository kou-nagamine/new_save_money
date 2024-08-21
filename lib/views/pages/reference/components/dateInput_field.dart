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

  @override
  void initState() {
    super.initState();
    // デフォルトの日付を設定。初期値がない場合は2024年1月1日に設定この部分はデータが格納された日付に変更する必要がある。
    _selectedDate = widget.initialDate ?? DateTime(2024, 1, 1);// <- ここ
    _controller.text = "${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.year}";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = "${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.year}";
        widget.onDateChanged(_selectedDate); // Notify the parent
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
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}
