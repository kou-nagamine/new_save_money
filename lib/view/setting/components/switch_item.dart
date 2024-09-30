import 'package:flutter/material.dart';

class SwitchItem extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchItem({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch.adaptive(
          applyCupertinoTheme: false,
          value: value,
          activeColor: Colors.white,
          activeTrackColor: Colors.green,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.black12,
          onChanged: onChanged, // 外部から渡されたコールバックを使用
        ),
      ],
    );
  }
}
