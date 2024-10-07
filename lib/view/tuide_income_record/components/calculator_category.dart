import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/view_model/temporary_list.dart';

final List<Map<String, dynamic>> choicesLists = [
  {
    'icon': Icons.local_drink,
    'color': Color(0xff0071FF),
    'label': '飲み物',
  },
  {
    'icon': Icons.lunch_dining,
    'color': Color(0xffFF9500),
    'label': '食事',
  },
  {
    'icon': Icons.icecream,
    'color': Color(0xff34C759),
    'label': '菓子類',
  },
  {
    'icon': Icons.star,
    'color': Color(0xffFF2D55),
    'label': 'その他',
  },
];

class CalculatorCateGory extends ConsumerStatefulWidget {
  const CalculatorCateGory({super.key});

  @override
  _CalculatorCateGoryState createState() => _CalculatorCateGoryState();
}

class _CalculatorCateGoryState extends ConsumerState<CalculatorCateGory> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Flexible(
      child: SizedBox(
        height: size.height * 0.07,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: choicesLists.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> choice = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: ChoiceChip(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                label: Transform.translate(
                  offset: const Offset(0, -1), // 文字の位置を少し上に調整
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        choice['icon'],
                        color: selectedIndex == index ? Colors.white : choice['color'],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        choice['label'],
                        style: TextStyle(
                          color: selectedIndex == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                selected: selectedIndex == index,
                selectedColor: choice['color'],
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: choice['color']),
                ),
                showCheckmark: false, 
                onSelected: (bool selected) {
                  setState(() {
                    selectedIndex = index;
                    final temporaryList = ref.read(temporaryListNotifierProvider.notifier);
                    temporaryList.updateState([
                      choice['label'],
                      choice['icon'],
                      choice['color'],
                    ]);
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}