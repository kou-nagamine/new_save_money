import 'package:flutter/material.dart';

class SwitchItem extends StatefulWidget {
  const SwitchItem({super.key});

  @override
  State<SwitchItem> createState() => _SwitchItemState();
}

class _SwitchItemState extends State<SwitchItem> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch.adaptive(
          applyCupertinoTheme: false,
          value: light,
          activeColor: Colors.white, // スイッチがオンのときの色
          activeTrackColor: Colors.green, // スイッチがオンのときのトラックの色
          inactiveThumbColor: Colors.grey, // スイッチがオフのときの色
          inactiveTrackColor: Colors.white, // スイッチがオフのときのトラックの色
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
        ),
      ],
    );
  }
}
