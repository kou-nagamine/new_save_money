//pakages
import 'package:flutter/material.dart';

//components
import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    //通常の行
    final List<List<Widget>> normalLines = [
      [const CalculatorButton(buttonText:'1'),const CalculatorButton(buttonText:'2'),const CalculatorButton(buttonText:'3'),const CalculatorButton(buttonText:'del')],
      [const CalculatorButton(buttonText:'4'),const CalculatorButton(buttonText:'5'),const CalculatorButton(buttonText:'6'),const CalculatorButton(buttonText:'C')],
      [const CalculatorButton(buttonText:'7'),const CalculatorButton(buttonText:'8'),const CalculatorButton(buttonText:'9'),const CalculatorButton(buttonText:'税')],
    ];
    
    //00（通常の２倍のサイズのbuttom）が含まれる行
    final List<Widget> specialLines = [
      const CalculatorButton(buttonText:'0'),const BigCalculatorButton(buttonText: '00',),const CalculatorButton(buttonText:'→')
    ];
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(60.0),
        ),
        color: Color.fromARGB(255, 234, 228, 228),
      ),
      width: size.width,
      height: size.height * 0.55,
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.07, bottom: size.height * 0.02, left: size.width * 0.03, right: size.width * 0.03),
        child: Column(
          children: <Widget>[
            Table(
              //border: TableBorder.all(),
              //列数を4列に指定
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
                3: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //各行を配置
              children: <TableRow>[
                ...normalLines.map((row) => TableRow(children: row)),
              ]
            ),
            Table(
              //border: TableBorder.all(),
              //列数を3列に指定
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //一行を追加
              children:  <TableRow>[
                TableRow(
                  children: specialLines.map((button) => button).toList(),
                ),
              ],
            ),
          ],
        )  
      ),
    );
  }
}