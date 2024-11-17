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
    
    final charge = ref.watch(chargeRiverpodNotifierProvider); //chargestateを監視 
    final Size size = MediaQuery.of(context).size; //画面のサイズを取得
    // final a = ref.watch(userLogNotifierProvider);
    
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.2),
      height: size.height * 0.3,
      width: size.height * 0.3, 
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // 円形にする
        gradient: RadialGradient(
          colors: [
            Color(0xffFFFFFF), // 中心の色
            Color(0x0047FF75), // 外側の色
          ],
          stops: [0,0.6],
          center: Alignment.center,
          radius: 0.9, // グラデーションの広がり具合
        ),
      ),
      child: Center(
        child: Text(
          '¥${NumberFormat("#,###").format(int.parse(charge))}',
          style: TextStyle(
            fontSize: size.width * 0.17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
