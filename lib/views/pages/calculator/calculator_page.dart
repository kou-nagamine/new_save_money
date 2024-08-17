//packages
import 'package:flutter/material.dart';

//components
import 'components/calculator.dart';
import 'components/charge_card.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
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