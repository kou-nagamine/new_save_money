import 'package:flutter/material.dart';

class MemoField extends StatelessWidget {
  final ValueChanged<String> onMemoChanged;
  final String initialMemo;

  MemoField({required this.onMemoChanged, required this.initialMemo});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialMemo,
      maxLength: 20,
      decoration: InputDecoration(
        hintText: "水筒を持参した分",
        border: InputBorder.none,
      ),
      onChanged: (value) {
        onMemoChanged(value);
      },
    );
  }
}
