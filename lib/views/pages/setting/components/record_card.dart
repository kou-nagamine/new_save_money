//package imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

//riverpods
import '/views/pages/calculator/providers/all_price.dart';

class RecordCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPrice = ref.watch(allPriceNotifierProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 4 / 5; // 画面幅の4/5に設定

    return Center(
      child:Container(
      width: cardWidth,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: EdgeInsets.only(top:20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xFF131313)
                            : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,  
            children:[
            SvgPicture.asset(
              "assets/images/deposit.svg",
              width: cardWidth * 4/7, 
              ),
            Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'あなたはこれまでに',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                 '¥ ${NumberFormat("#,###").format(allPrice[0])}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
              Text(
                '我慢しました！',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
            
          ),
          ],
          ),
        ),
      ),
    ),
    );
  }
}