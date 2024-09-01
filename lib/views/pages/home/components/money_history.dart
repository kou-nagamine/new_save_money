import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';

import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート

class MoneyHistoryList extends ConsumerWidget {
  const MoneyHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider); // Riverpodのプロバイダを監視し、状態の変更を反映

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: userSaveLog.length, // 履歴データの数だけリストアイテムを作成
      itemBuilder: (context, index) {
        final item = userSaveLog[index]; // 各アイテムのデータを取得

        // Save 型のプロパティを取得
        final String categoryName = item.name;
        final IconData categoryIcon = item.icon;
        final Color color = item.color;
        final bool payment = item.payment; // 用途（入金か出金）を取得
        final int price = item.price;

        // 用途に応じて色を変更
        final Color priceColor = payment ?  Color(0xFF2CB13C) : Color(0xFFE82929);

        return Dismissible(
          key: Key(item.toString()),
          onDismissed: (direction) {
            final price = item.price; // 削除する項目の価格を取得
            ref.read(userLogNotifierProvider.notifier).deleteLog(index); // データを削除
            ref.read(allPriceNotifierProvider.notifier).deletePrice(payment,price); // トータル金額から削除
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
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
              title: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                ),
              ),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  categoryIcon,
                  size: 20,
                  color: color,
                ),
              ),
              trailing: Text(
                "¥${NumberFormat("#,###").format(price)}",
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