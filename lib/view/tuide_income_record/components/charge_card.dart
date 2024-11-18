//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // NumberFormat を使用するためにインポート

//riverpods
import '../../../view_model/charge_riverpod.dart';

class ChargeCard extends ConsumerWidget {
  const ChargeCard({super.key});

 @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charge = ref.watch(chargeRiverpodNotifierProvider); // chargeStateを監視
    final Size size = MediaQuery.of(context).size; // 画面のサイズを取得

    final taxState = ref.watch(chargeRiverpodNotifierProvider.notifier).taxState;
    String taxRateText;
    if (taxState == 0) {
      taxRateText = "税率: なし";
    } else if (taxState == 1) {
      taxRateText = "税率: 8%";
    } else {
      taxRateText = "税率: 10%";
    }


    return Stack(
      alignment: Alignment.center,
      children: [
        // 背景の円
        Container(
          height: size.height * 0.3,
          width: size.height * 0.3,
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // 円形にする
            gradient: RadialGradient(
              colors: [
                Color(0xffFFFFFF), // 中心の色
                Color(0x0047FF75), // 外側の色
              ],
              stops: [0, 0.6],
              center: Alignment.center,
              radius: 0.9, // グラデーションの広がり具合
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min, // 内容に合わせてサイズを調整
          children: [
            // 税率表示
            Text(
              taxRateText,
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '¥${NumberFormat("#,###").format(int.parse(charge))}',
              style: TextStyle(
                fontSize: size.width * 0.17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}