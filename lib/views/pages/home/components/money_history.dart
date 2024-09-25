import 'dart:developer';
import '../../home/providers/save.dart';

import 'package:figma_squircle/figma_squircle.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';
import 'package:intl/intl.dart';
import "../../detail/detail_page.dart";

class MoneyHistoryList extends ConsumerWidget {
  const MoneyHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);

    // 最新の deposit = false のアイテムのインデックスを取得
    final firstDepositFalseIndex = userSaveLog.indexWhere((item) => !item.deposit);

    // A: 割り当て済みのアイテム、B: 割り当て済みでないアイテムのリスト
    List<int> assignedIndexes = [];
    List<int> unassignedIndexes = [];
    List<int> inUseIndexes = [];

    for (int index = 0; index < userSaveLog.length; index++) {
      final item = userSaveLog[index];

      // unassignedIndexes に追加: deposit == false または status != SaveStatus.used のもの
      if (item.status == SaveStatus.unUsed) {
        unassignedIndexes.add(index);
      }

      // assignedIndexes に追加: deposit == true かつ status == SaveStatus.used のもの
      if (item.status == SaveStatus.used) {
        assignedIndexes.add(index);
      }

      //
      if (item.status == SaveStatus.inUse) {
        inUseIndexes.add(index);
      }
    }

    final itemCount = unassignedIndexes.length +
                      (inUseIndexes.isNotEmpty ? 1 : 0) + // 使用中ラベル
                      inUseIndexes.length +
                      (assignedIndexes.isNotEmpty ? 1 : 0) + // 割り当て済みラベル
                      assignedIndexes.length;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: itemCount,
      itemBuilder: (context, index) {

        // 使用中ラベルの前に未使用アイテムを表示
        if (index < unassignedIndexes.length) {
          final itemIndex = unassignedIndexes[index];
          final item = userSaveLog[itemIndex];

          // Dismissibleで囲む条件
          final shouldWrapWithDismissible = firstDepositFalseIndex == -1 || itemIndex <= firstDepositFalseIndex;

          Widget listTile = buildListTile(context, ref, itemIndex);

          if (shouldWrapWithDismissible) {
            listTile = Dismissible(
              key: Key(item.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                ref.read(userLogNotifierProvider.notifier).deleteLog(itemIndex);
                ref.read(allPriceNotifierProvider.notifier).deletePrice(item.deposit, item.price);
              },
              background: Container(
                
                alignment: Alignment.centerRight, // アイコンを右側に配置
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              child: listTile,
            );
          }
          return listTile;
        }

        // 「n%割り当て中」ラベル　
        if (index == unassignedIndexes.length && inUseIndexes.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              '使用中',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }

        // 割り当て中のアイテムを表示
        if (index < unassignedIndexes.length + inUseIndexes.length + (inUseIndexes.isNotEmpty ? 1 : 0)) {
          final inUseIndex = index - unassignedIndexes.length - (inUseIndexes.isNotEmpty ? 1 : 0); // ラベル分の補正
          final itemIndex = inUseIndexes[inUseIndex];
          final item = userSaveLog[itemIndex];

          // Dismissibleで囲む条件
          final shouldWrapWithDismissible = firstDepositFalseIndex == -1 || itemIndex <= firstDepositFalseIndex;

          Widget listTile = buildListTile(context, ref, itemIndex);

          if (shouldWrapWithDismissible) {
            listTile = Dismissible(
              key: Key(item.toString()),
              onDismissed: (direction) {
                ref.read(userLogNotifierProvider.notifier).deleteLog(itemIndex);
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
          return listTile;
        }

        // 4. 割り当て済みラベルを表示（assignedIndexesが空でない場合のみ）
        if (index == unassignedIndexes.length + inUseIndexes.length + (inUseIndexes.isNotEmpty ? 1 : 0) &&
            assignedIndexes.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              '割り当て済み',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
        
        // 5. 割り当て済みのアイテムを表示
        final assignedIndex = index - unassignedIndexes.length - inUseIndexes.length - 
                              (inUseIndexes.isNotEmpty ? 2 : 1); // ラベル分の補正
        final itemIndex = assignedIndexes[assignedIndex];
        final item = userSaveLog[itemIndex];

        // Dismissibleで囲む条件
        final shouldWrapWithDismissible = firstDepositFalseIndex == -1 || itemIndex <= firstDepositFalseIndex;

        Widget listTile = buildListTile(context, ref, itemIndex);

        if (shouldWrapWithDismissible) {
          listTile = Dismissible(
            key: Key(item.toString()),
            onDismissed: (direction) {
              ref.read(userLogNotifierProvider.notifier).deleteLog(itemIndex);
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
        return listTile;
      },
    );
  }
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