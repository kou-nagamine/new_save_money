import 'package:figma_squircle/figma_squircle.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart'as iconoir;
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';
import 'package:intl/intl.dart'; // NumberFormatを使用するためにインポート
import "/views/pages/reference/reference_page.dart"; // HomePage のインポートを忘れずに

class MoneyHistoryList extends ConsumerWidget {
  const MoneyHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider); // Riverpodのプロバイダを監視し、状態の変更を反映

    // 最新の deposit = false のアイテムのインデックスを取得
    final firstDepositFalseIndex = userSaveLog.indexWhere((item) => !item.deposit);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: userSaveLog.length, // 履歴データの数だけリストアイテムを作成
      itemBuilder: (context, index) {
        final item = userSaveLog[index]; // 各アイテムのデータを取得

        // Save 型のプロパティを取得
        final String categoryName = item.name;
        final IconData categoryIcon = item.icon;
        final Color color = item.color;
        final bool deposit = item.deposit; // 用途（入金か出金）を取得
        final int price = item.price;

        // 用途に応じて色を変更
        final Color priceColor = deposit ? Colors.black : Color(0xFFE82929);

        // Dismissibleで囲む条件: 最新の deposit = false のアイテム以前のもの、または deposit = false がない場合
        final shouldWrapWithDismissible = firstDepositFalseIndex == -1 || index <= firstDepositFalseIndex;

        if (shouldWrapWithDismissible) {
          return Dismissible(
            key: Key(item.toString()),
            onDismissed: (direction) {
              final price = item.price; // 削除する項目の価格を取得
              ref.read(userLogNotifierProvider.notifier).deleteLog(index); // データを削除
              ref.read(allPriceNotifierProvider.notifier).deletePrice(deposit, price); // トータル金額から削除
            },
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            child: buildListTile(context, categoryName, categoryIcon, color, price, priceColor, deposit),
          );
        } else {
          // Dismissible で囲まない通常の ListTile
          return buildListTile(context, categoryName, categoryIcon, color, price, priceColor, deposit);
        }
      },
    );
  }

  // 共通のListTileビルダー
  Widget buildListTile(BuildContext context, String categoryName, IconData categoryIcon, Color color, int price, Color priceColor, bool deposit) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(0),
      decoration: ShapeDecoration(
        //color: Color(0xffD9D9D9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffDDDDDD),
            width: 1.5,
          ),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 20,
            cornerSmoothing: 0.7,
          ),
        )
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color(0xff3C3C43),
          ),
        ),
        subtitle: Text(
          "2021/10/10",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color(0xffA4A4A4),
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xffF1F1F1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            categoryIcon,
            size: 20,
            color: color,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // trailing内のアイテムの横幅を最小限にする
          children: [
            Text(
              "¥${NumberFormat("#,###").format(price)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: priceColor,
              ),
            ),
            Opacity(
            opacity: deposit ? 0.0 : 1.0, // depositがtrueなら透明に
            child: Icon(
              Icons.chevron_right_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
        onTap: () {
          // depositがfalseの場合のみReferencePageに遷移
          if (!deposit) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReferencePage(),
              ),
            );
          }
        },
      )
    );
  }
}

