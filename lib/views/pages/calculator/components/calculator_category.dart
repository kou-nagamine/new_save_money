import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/calculator/providers/temporary_list.dart';



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

class CalculatorCateGory extends ConsumerStatefulWidget {
  const CalculatorCateGory({super.key});

  @override
  _CalculatorCateGoryState createState() => _CalculatorCateGoryState();
}

class _CalculatorCateGoryState extends ConsumerState<CalculatorCateGory> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Flexible(
      child: SizedBox(
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
                  final temporaryList = ref.read(temporaryListNotifierProvider.notifier);
                  temporaryList.updateState([
                    _labels[index],
                    _icons[index],
                    _colors[index],
                  ]);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: SizedBox(
                  width: size.width * 0.28,
                  height: size.height * 0.04,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? _colors[index]
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
                          Icon(_icons[index], 
                          color: selectedIndex == index
                            ? Colors.white
                            :  _colors[index]),
                          const SizedBox(width: 4.0),
                          Text(
                            _labels[index],
                            style: TextStyle(
                              color: selectedIndex == index
                                ? Colors.white
                                :  Colors.black,
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
      )
    );
  }
}

