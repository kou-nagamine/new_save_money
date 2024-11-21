//package
import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:new_save_money/view_model/user_log.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'dart:developer';
import '../../model/save.dart';

// components
import 'components/payment_contet.dart';

class ReferencePage extends ConsumerWidget {

  final String title;
  final int itemIndex;

  const ReferencePage({
    required this.title,
    required this.itemIndex,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);
    // 該当アイテムを取得
    final item = userSaveLog[itemIndex];
    final id = item.linkedDepositId;
    final DateTime date = item.dataTime;
    final int price = item.price;
    final String memo = item.memo;
    final String formattedPercentage =userSaveLog[itemIndex].salePercentage?.toStringAsFixed(1) ?? "0.0" ;
     // linkedDepositIdと合致するWithdrawalを取得
    // linkedDepositIdと合致する Save オブジェクトを取得
    final filteredWithdrawals = userSaveLog.where((log) =>
        log.deposit == true && 
        log.linkedWithdrawals.any((withdrawal) => withdrawal.id == item.linkedDepositId)
    ).toList();

     return Scaffold(
      body: DraggableHome(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("支出の履歴", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context, ref),
        headerExpandedHeight: 0.5,
        body: [
          SingleChildScrollView(
            child: Column(
              children: [
                PaymentContet(
                  date: date,
                  price: price,
                  compensatingRatio: formattedPercentage,
                  memo: memo,
                ),
                //ListViewにbuildListTileを使用
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  physics: const NeverScrollableScrollPhysics(), // スクロールを無効化
                  shrinkWrap: true, // ListViewが自身の高さを決定する
                  itemCount: filteredWithdrawals.length, // データの長さを指定
                  itemBuilder: (context, index) {
                    // フィルタリングされたリストを使って描画
                    return buildListTile(context, ref, filteredWithdrawals[index], id); // buildListTileを呼び出す
                  },
                ),
              ],
            )
          )
        ],
      ),
    );
  }
  

  Widget headerWidget(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);
    final item = userSaveLog[itemIndex];
    final String imageUrl = item.imageUrl;
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover, // 画像を全体にカバー
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.9), // 90%の不透明度の黒
                Colors.white.withOpacity(0), // 白
              ],
              stops: [0.1, 1], // 黒が85%の位置で終了し、残りは白
            ),
          ),
          child: Column(
            children: [
              Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
        Positioned(
          top: 50,
          left: 10,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context); // 前のページに戻る
                },
                icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Colors.black,
                  weight: 700,
                  size: 50,
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          )
        ),
      ],
    );
  }
}

Widget buildListTile(BuildContext context, WidgetRef ref, Save item, String? linkedDepositId) {
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

  // linkedDepositId に一致する Withdrawal の amount を取得
  final linkedWithdrawalAmount = item.linkedWithdrawals
      .firstWhere(
        (withdrawal) => withdrawal.id == linkedDepositId,
        orElse: () => Withdrawal(id: '', amount: 0), // デフォルト値として 0 の Withdrawal
      )
      .amount;

  // amount を item.price で割って割合を計算
  final double adjustedPercentage = price > 0 ? linkedWithdrawalAmount / price : 0.0;

  // log('Item: $categoryName, Remaining Percentage: $remainingPercentage, Adjusted Percentage: $adjustedPercentage');

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
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * (adjustedPercentage), // adjustedPercentage を使用
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