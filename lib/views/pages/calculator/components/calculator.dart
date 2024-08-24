import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/home/providers/user_log.dart';

//components
import 'calculator_button.dart';

//riverpods
import '../providers/charge_riverpod.dart';

class Calculator extends ConsumerStatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator> {
  int selectedIndex = 1; // 初期インデックスを0に設定

  final List<IconData> _icons = [
    Icons.lunch_dining, // 食事
    Icons.local_drink, // 飲み物
    Icons.icecream, // 菓子類
    Icons.star, // その他
  ];

  final List<String> _labels = [
    '食事',
    '飲み物',
    '菓子類',
    'その他',
  ];

  final List<Color> _colors = [
    Colors.orange,
    Colors.blue,
    Colors.lightGreen,
    Colors.green,
  ];
  
  // デフォルトカテゴリデータ
  List<dynamic> categoryData = [
    {
      '飲み物',
      Icons.local_drink,
      Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
        categoryData: categoryData,
        isEnabled: parsedChageState >= 1,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        color: Color.fromARGB(255, 234, 228, 228),
      ),
      width: size.width,
      height: size.height * 0.55,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: size.height * 0.02, left: size.width * 0.03, right: size.width * 0.03),
        child: Column(
          children: <Widget>[
            // ここに食べ物ののドロップナビゲーションを追加
            SizedBox(
              height: size.height * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _icons.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        categoryData = [
                          {
                            _labels[index],
                            _icons[index],
                            _colors[index],
                          },
                        ];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                      child: SizedBox(
                        width: size.width * 0.2,
                        height: size.height * 0.04,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? _colors[index].withOpacity(0.1)
                                : null,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(color: _colors[index]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(_icons[index], color: _colors[index]),
                                const SizedBox(width: 4.0),
                                Text(
                                  _labels[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
