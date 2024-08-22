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
    ref.watch(userLogNotifierProvider);

    return ListView.builder(
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        final item = historyData[index];
        final String categoryName = item['categoryName'];
        final String categoryIcon = item['categoryIcon'];
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
                _getIconForCategory(categoryIcon),
                size: 40,
                color: Colors.black,
              ),
            ),
            trailing: Text("￥$price",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2CB13C)
              ),
           ),  
          )
        );
      },
    );
  }
}