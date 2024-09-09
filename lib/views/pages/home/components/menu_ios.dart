import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PaymentMenu extends StatefulWidget {
  const PaymentMenu({super.key});

    @override
  _PaymentMenuState createState() => _PaymentMenuState();
}

class _PaymentMenuState extends State<PaymentMenu> {
  // 現在選択されているメニューアイテム
  String selectedItem = '全て';

  @override
  Widget build(BuildContext context) {
  return MenuItem(
    selectedItem: selectedItem, // 選択された項目を渡す
    onItemSelected: (String item) {
      setState(() {
        selectedItem = item; // 新しい選択項目に更新
      });
    },
    builder: (_, showMenu) => TextButton(
      onPressed: showMenu,
      child: Text(
        selectedItem,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          ),
        ), // 選択された項目を表示
      ),
    );
  }
}


class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.builder,
    required this.selectedItem,
    required this.onItemSelected,
  });

  final PullDownMenuButtonBuilder builder;
  final String selectedItem; // 選択されているテキスト
  final ValueChanged<String> onItemSelected; // 選択が変更されたときのコールバック

  @override
  Widget build(BuildContext context) => PullDownButton(
    itemBuilder: (context) => [
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('全て'); // 項目が選択されたらコールバックを呼び出す
        },
        title: '全て',
        selected: selectedItem == '全て',
      ),
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('ついで');
        },
        title: 'ついで',
        selected: selectedItem == 'ついで',
      ),
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('割当て');
        },
        title: '割当て',
        selected: selectedItem == '割当て',
      ),
    ],
    animationBuilder: null,
    position: PullDownMenuPosition.automatic,
    buttonBuilder: builder, // builderを渡す
  );
}
