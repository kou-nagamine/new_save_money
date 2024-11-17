import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/view/tuide_income_record/components/calculator_category.dart';

//components
import 'calculator_button.dart';

//riverpods
import '../../../view_model/charge_riverpod.dart';

class Calculator extends ConsumerStatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double calculatorHeight = size.height < 700 ? 390 : 410;

    // 変更された状態を取得
    final chageState = ref.watch(chargeRiverpodNotifierProvider);
    final int parsedChageState = int.parse(chageState);

    // 通常の行
    final List<List<Widget>> normalLines = [
      [const CalculatorButton(buttonText: '1'), const CalculatorButton(buttonText: '2'), const CalculatorButton(buttonText: '3'), const CalculatorButton(buttonText: 'del')],
      [const CalculatorButton(buttonText: '4'), const CalculatorButton(buttonText: '5'), const CalculatorButton(buttonText: '6'), const CalculatorButton(buttonText: 'C')],
      [const CalculatorButton(buttonText: '7'), const CalculatorButton(buttonText: '8'), const CalculatorButton(buttonText: '9'), const CalculatorButton(buttonText: '税')],
    ];

    // 00（通常の2倍のサイズのbutton）が含まれる行
    final List<Widget> specialLines = [
      CalculatorButton(
        buttonText: '0',
        isEnabled: parsedChageState >= 1 ,
      ),
      BigCalculatorButton(
        buttonText: '00',
        isEnabled: parsedChageState >= 1,
      ),
      CalculatorButton(
        buttonText: '→',
        isEnabled: parsedChageState >= 1,
      ),
    ];

    return Container(
      width: size.width,
      height: calculatorHeight,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.height * 0.02, left: size.width * 0, right: size.width * 0, top: size.height * 0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.02),
              padding: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
              child: CalculatorCateGory(),
            ),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
                3: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                ...normalLines.map((row) => TableRow(children: row)),
              ],
            ),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children: specialLines.map((button) => button).toList()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
