import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';

class MoneyHistoryList extends ConsumerWidget {
  final List<Map<String, dynamic>> historyData;
  MoneyHistoryList({required this.historyData});

  // アイコン名を文字列からIconDataに変換するメソッド
  IconData _getIconForCategory(String categoryIcon) {
    switch (categoryIcon) {
      case 'food':
        return Icons.lunch_dining;
      case 'drink':
        return Icons.local_drink;
      case 'sweet':
        return Icons.local_cafe;
      default:
        return Icons.help; // デフォルトアイコン
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userLogNotifierProvider);// Riverpodのプロバイダを監視し、状態の変更を反映

    return ListView.builder(
      itemCount: historyData.length,// 履歴データの数だけリストアイテムを作成
      itemBuilder: (context, index) {
        final item = historyData[index]; // 各アイテムのデータを取得
        
        // `categoryName` から各要素を取り出す
        final Set<dynamic> categoryNameSet = item['categoryName'];
        IconData categoryIcon = categoryNameSet.firstWhere((element) => element is IconData);// アイコンデータを取得
        String categoryName = categoryNameSet.firstWhere((element) => element is String);// カテゴリ名を取得
        Color color = categoryNameSet.firstWhere((element) => element is Color); // 色データを取得
        
        final int price = item['price'];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
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
                size: 40,
                color: color,
              ),
            ),
            trailing: Text(
              "￥$price",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2CB13C),
              ),
            ),
          ),
        );
      },
    );
  }
}
