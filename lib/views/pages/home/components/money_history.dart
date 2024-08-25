import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';

class MoneyHistoryList extends ConsumerWidget {
  final List<Map<String, dynamic>> historyData;
  MoneyHistoryList({required this.historyData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userLogNotifierProvider); // Riverpodのプロバイダを監視し、状態の変更を反映

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: historyData.length, // 履歴データの数だけリストアイテムを作成
      itemBuilder: (context, index) {
        final item = historyData[index]; // 各アイテムのデータを取得

        // アイコン、カテゴリ名、色データを取得
        final String categoryName = item['categoryName'];
        final IconData categoryIcon = item['categoryIcon'];
        final Color color = item['color'];
        final String purpose = item['purpose']; // 用途データを取得
        final int price = item['price'];

        // purpose に応じて色を変更
        final Color priceColor = purpose == '入金' ? Color(0xFF2CB13C) : Color(0xFFE82929);

        return Dismissible(
          key: Key(item.toString()),
          onDismissed: (direction) {
            final price = item['price']; // 削除する項目の価格を取得
            ref.read(userLogNotifierProvider.notifier).deleteLog(index); // データを削除
            ref.read(allPriceNotifierProvider.notifier).subtractPrice(price); // トータル金額から削除

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('$categoryName を削除しました'),
            //     action: SnackBarAction(
            //       label: "元に戻す",
            //       onPressed: () {
            //         ref.read(userLogNotifierProvider.notifier).undoDelete(index, item);
            //       },
            //     ),
            //   ),
            // );
          },
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
              title: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  categoryIcon,
                  size: 30,
                  color: color,
                ),
              ),
              trailing: Text(
                "￥${price}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: priceColor, // ここで色を設定
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
