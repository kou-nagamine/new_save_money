import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/view_model/log_type.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io' show Platform;

class PaymentMenu extends ConsumerStatefulWidget {
  const PaymentMenu({super.key});

  @override
  _PaymentMenuState createState() => _PaymentMenuState();
}

class _PaymentMenuState extends ConsumerState<PaymentMenu> {
  // 現在選択されているメニューアイテム
  String selectedItem = '全体';

  @override
  void initState() {
    super.initState();
    _loadSelectedItem(); // 保存された項目を読み込み
  }

  Future<void> _loadSelectedItem() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedItem = prefs.getString('selectedItem') ?? '全体'; // 以前の状態を読み込むか、デフォルトで「全体」
    });
  }

  Future<void> _saveSelectedItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedItem', item); // 選択された項目を保存
  }


  // 選択されたメニュー項目に基づいて処理を実行するメソッド
  void _onMenuItemSelected(String newValue, WidgetRef ref) {
    setState(() {
      selectedItem = newValue;
    });

    _saveSelectedItem(newValue);

    // 選択されたメニュー項目に基づいた処理を実行
    switch (newValue) {
      case '全体':
        _handleSelectAll(ref);
        break;
      case 'ついで収入':
        _handleSelectDeposit(ref);
        break;
      case '支出':
        _handleSelectExpense(ref);
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildIOSMenu()
        : _buildAndroidMenu(ref); // ref を渡すように変更
  }

  // iOSのメニュー
  Widget _buildIOSMenu() {
    return MenuItem(
      selectedItem: selectedItem, // 選択された項目を渡す
      onItemSelected: (String item) {
        setState(() {
          selectedItem = item; // 新しい選択項目に更新
        });
        _saveSelectedItem(item); // 項目が変更されたら保存
      },
      builder: (_, showMenu) => TextButton(
        onPressed: showMenu,
        child: Row(
          children: [
            Text(
              selectedItem,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ), // 選択された項目を表示
            const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black,),
          ],
        ),
      ),
    );
  }

  // Androidのメニュー
 Widget _buildAndroidMenu(WidgetRef ref) {
    return IntrinsicWidth( // IntrinsicWidthで包んで最小限の幅に調整
      child: DropdownButton<String>(
        value: selectedItem,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 20,
        elevation: 16,
        alignment: Alignment.center,
        style: const TextStyle(
          color: Colors.black, 
          fontSize: 16, 
          fontWeight: FontWeight.bold,
        ),
        underline: SizedBox(), // 下線を非表示
        onChanged: (String? newValue) {
          _onMenuItemSelected(newValue!, ref); // 選択処理を別メソッドに分離
        },
        items: <String>['全体', 'ついで収入', '支出']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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

 // 全体を選択した時の処理
  void _handleSelectAll(WidgetRef ref) {
    final chngeType = ref.read(logTypeNotifierProvider.notifier);
    chngeType.selectAllType();
  }

  // ついで収入を選択した時の処理
  void _handleSelectDeposit(WidgetRef ref) {
    final chngeType = ref.read(logTypeNotifierProvider.notifier);
    chngeType.selectDepositType();
  }

  // 支出を選択した時の処理
  void _handleSelectExpense(WidgetRef ref) {
    final chngeType = ref.read(logTypeNotifierProvider.notifier);
    chngeType.selectExpenseType();
  }

