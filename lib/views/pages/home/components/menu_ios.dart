import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/home/providers/log_type.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PaymentMenu extends StatefulWidget {
  const PaymentMenu({super.key});

    @override
  _PaymentMenuState createState() => _PaymentMenuState();
}

class _PaymentMenuState extends State<PaymentMenu> {
  // 現在選択されているメニューアイテム
  String selectedItem = '全体';

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


class MenuItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) => PullDownButton(
    itemBuilder: (context) => [
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('全体'); // 項目が選択されたらコールバックを呼び出す
          ref.watch(logTypeNotifierProvider);
          final chngeType = ref.read(logTypeNotifierProvider.notifier);
          chngeType.selectAllType();
        },
        title: '全体',
        selected: selectedItem == '全体',
      ),
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('ついで収入');
          ref.watch(logTypeNotifierProvider);
          final chngeType = ref.read(logTypeNotifierProvider.notifier);
          chngeType.selectDepositType();
        },
        title: 'ついで収入',
        selected: selectedItem == 'ついで収入収入',
      ),
      PullDownMenuItem.selectable(
        onTap: () {
          onItemSelected('支出');
          ref.watch(logTypeNotifierProvider);
          final chngeType = ref.read(logTypeNotifierProvider.notifier);
          chngeType.selectExpenseType();
        },
        title: '支出',
        selected: selectedItem == '支出',
      ),
    ],
    animationBuilder: null,
    position: PullDownMenuPosition.automatic,
    buttonBuilder: builder, // builderを渡す
  );
}
