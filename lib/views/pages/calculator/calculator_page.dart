//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/home/providers/user_log.dart';

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
          //ChargeCardの配置
          Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: const Align(
              alignment: Alignment(0, -0.7), // 中心から少し下に配置
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