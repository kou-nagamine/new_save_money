//packages
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/home/providers/user_log.dart';
import 'package:intl/intl.dart'; // NumberFormat を使用するためにインポート

//commons
import '../../commons/navigation_bar/navigation_bar.dart';

//riverpods
import '../providers/charge_riverpod.dart';

class ChargeCard extends ConsumerWidget {
  const ChargeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final charge = ref.watch(chargeRiverpodNotifierProvider); //chargestateを監視 
    final Size size = MediaQuery.of(context).size; //画面のサイズを取得
    // final a = ref.watch(userLogNotifierProvider);
    
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.1),
      height: size.height * 0.23,
      child: Card(
        color: const Color(0xff0085FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 縦方向に中央揃え
                crossAxisAlignment: CrossAxisAlignment.center, // 横方向に中央揃え
                children: [
                  //我慢した金額の表示
                  Text(
                    'ついで収入はいくら？',
                      style:TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.white
                      ),
                    ),
                    //金額の表示(chargeProviderの表示)
                  Text(
                    NumberFormat("#,###").format(int.parse(charge)),
                    style: TextStyle(
                      fontSize: size.width * 0.15,
                      color: Colors.white
                    )
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
