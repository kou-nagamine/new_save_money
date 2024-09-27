import 'dart:developer';
import '../../home/providers/save.dart';

import 'package:figma_squircle/figma_squircle.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart"; // 見た目を管理するものを使ってると考える
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_log.dart';
import 'package:new_save_money/views/pages/calculator/providers/all_price.dart';
import 'package:intl/intl.dart';
import 'log_tile.dart';

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

      // unassignedIndexesに追加：deposit == false または status != SaveStatus.used のもの
      if (item.status == SaveStatus.unUsed) {
        unassignedIndexes.add(index);
      }

      // assignedIndexesに追加：deposit == true かつ status == SaveStatus.used のもの
      if (item.status == SaveStatus.used) {
        assignedIndexes.add(index);
      }

      // inUsedIndexesに追加：status == SaveStatus.inUsed
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
          final itemIndex = inUseIndexes[inUseIndex]; // itemがuserLogに置かれている位置
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

// 
class DepositList extends ConsumerWidget {
  const DepositList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);

    // deposit == true のアイテムだけをフィルタリングし、そのインデックスも保持
    final depositTrueIndexes = <int>[];
    for (int i = 0; i < userSaveLog.length; i++) {
      if (userSaveLog[i].deposit == true) {
        depositTrueIndexes.add(i); // deposit == true の元のリストのインデックスを保存
      }
    }

    // フィルタリングしたアイテム数を設定
    final itemCount = depositTrueIndexes.length;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // 元のリストのインデックスを取得
        final originalIndex = depositTrueIndexes[index];
        
        // 正しいインデックスを使って ListTile を生成
        Widget listTile = buildListTile(context, ref, originalIndex);

        return listTile;
      },
    );
  }
}

class ExpencesList extends ConsumerWidget {
  const ExpencesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);

    // deposit == false のアイテムだけをフィルタリングし、そのインデックスも保持
    final depositFalseIndexes = <int>[];
    for (int i = 0; i < userSaveLog.length; i++) {
      if (userSaveLog[i].deposit == false) {
        depositFalseIndexes.add(i); // deposit == false の元のリストのインデックスを保存
      }
    }

    // フィルタリングしたアイテム数を設定
    final itemCount = depositFalseIndexes.length;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // 元のリストのインデックスを取得
        final originalIndex = depositFalseIndexes[index];
        
        // 正しいインデックスを使って ListTile を生成
        Widget listTile = buildListTile(context, ref, originalIndex);

        return listTile;
      },
    );
  }
}