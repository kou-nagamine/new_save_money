//packages
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/home/providers/user_log.dart';

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
      height: size.height * 0.23,
      child: Card(
        color: const Color.fromARGB(255, 8, 101, 177),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            //矢印のアイコン
            Container(
              transform: Matrix4.rotationZ(270 * pi / 180),
              transformAlignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommonNavigationBar()),
                  );
                },
                icon: Icon(
                  Icons.arrow_upward,
                  color:Colors.white,
                  size: size.width * 0.12,
                )
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  //我慢した金額の表示
                  Align(
                    alignment: const Alignment(-0.4,-0.6),
                    child:Text(
                    '我慢した金額は ？',
                      style:TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.white
                      ),
                    ),
                  ),
                  //金額の表示(chargeProviderの表示)
                  Align(
                    alignment: const Alignment(-0.3,0.2),
                    child:Text(
                      charge,
                      style: TextStyle(
                        fontSize: size.width * 0.17,
                        color: Colors.white
                      )
                    ),
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
