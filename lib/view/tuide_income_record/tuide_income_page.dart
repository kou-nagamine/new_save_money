//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/view/tuide_income_record/components/calculator_category.dart';

//components
import 'components/calculator.dart';
import 'components/charge_card.dart';

class CalculatorPage extends ConsumerWidget {
  const CalculatorPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //背景のグラデーション
           Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff1FEE53), // 開始色
                  Color(0xff14A237), // 終了色
                ],
              ),
            ),
          ),
          //ChargeCardの配置
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.01, left: size.width * 0.01),
            child: const Align(
              alignment: Alignment(0, -0.8), // 中心から少し下に配置
              child: ChargeCard(),
            ),
          ),
          //Calculatorの配置
          const Align(
            alignment:Alignment.bottomCenter,
            child:Calculator(),
          )
        ]  
      )
    );
  }
}