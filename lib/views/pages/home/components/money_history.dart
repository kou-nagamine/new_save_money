import 'dart:developer';
import '../../home/providers/save.dart';

import 'package:figma_squircle/figma_squircle.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';
import 'package:intl/intl.dart';
import "/views/pages/reference/reference_page.dart";

class MoneyHistoryList extends ConsumerWidget {
  const MoneyHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);

    // 最新の deposit = false のアイテムのインデックスを取得
    final firstDepositFalseIndex = userSaveLog.indexWhere((item) => !item.deposit);

    // 「割り当て済み」ラベルが挿入されたかどうかを追跡
    bool assignedLabelInserted = false;
    bool inAssignedLabelInserted = false;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: userSaveLog.length,
      itemBuilder: (context, index) {
        final item = userSaveLog[index];

        // Dismissibleで囲む条件: 最新の deposit = false のアイテム以前のもの、または deposit = false がない場合
        final shouldWrapWithDismissible = firstDepositFalseIndex == -1 || index <= firstDepositFalseIndex;

        // 「割り当て済み」ラベルを挿入する条件
        final assignLabel = item.deposit && item.status == SaveStatus.used && !assignedLabelInserted;

        final inAssignLabel = item.deposit && item.status == SaveStatus.inUse && !inAssignedLabelInserted;

        // ウィジェットリストを作成
        List<Widget> widgets = [];

        // 「割り当て済み」ラベルを挿入
        if (assignLabel) {
          assignedLabelInserted = true; // ラベルが挿入されたことを記録
          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                '割り当て済み',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        if (inAssignLabel) {
          inAssignedLabelInserted = true; // ラベルが挿入されたことを記録
          // remainingPercentageを100分率に変換して整数にする
          int percentage = (100 - (item.remainingPercentage * 100)).round();
          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                '${percentage}%割り当て中',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        // Dismissibleで囲むかどうかの条件に従い、リストアイテムを追加
        Widget listTile = buildListTile(context, ref, index);
        if (shouldWrapWithDismissible) {
          listTile = Dismissible(
            key: Key(item.toString()),
            onDismissed: (direction) {
              ref.read(userLogNotifierProvider.notifier).deleteLog(index);
              ref.read(allPriceNotifierProvider.notifier).deletePrice(item.deposit, item.price);
            },
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            child: listTile,
          );
        }

        // リストアイテムを追加
        widgets.add(listTile);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        );
      },
    );
  }

  // 共通のListTile
  Widget buildListTile(BuildContext context, WidgetRef ref, int index) {
    final userSaveLog = ref.watch(userLogNotifierProvider);
    final item = userSaveLog[index];

    // Save 型のプロパティを取得
    final String categoryName = item.name;
    final IconData categoryIcon = item.icon;
    final Color color = item.color;
    final bool deposit = item.deposit;
    final int price = item.price;
    final DateTime date = item.dataTime;
    final double remainingPercentage = item.remainingPercentage;

    // 用途に応じて色を変更
    final Color priceColor = deposit ? Colors.black : Color(0xFFE82929);

    log('Item: $categoryName, Remaining Percentage: $remainingPercentage');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(0),
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffDDDDDD),
            width: 1.5,
          ),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 20,
            cornerSmoothing: 0.7,
          ),
        ),
      ),
      child: Stack(
        children: [
          ListTile(
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
              '${date.year}年${date.month}月${date.day}日', // 必要に応じて実際の日付に変更
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
              mainAxisSize: MainAxisSize.min,
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
                  opacity: deposit ? 0.0 : 1.0,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {
              if (!deposit) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReferencePage(
                      title: categoryName,
                      itemIndex: index,
                    ),
                  ),
                );
              }
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * (1.0 - remainingPercentage),
                decoration: ShapeDecoration(
                  color: Color(0xffD9D9D9).withOpacity(0.5), // 灰色で透明なオーバーレイ
                  shape: RoundedRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 0.7,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}