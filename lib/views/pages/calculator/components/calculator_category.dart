import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/views/pages/calculator/providers/temporary_list.dart';


final List<Map<String, dynamic>> choicesLists = [
  {
    'icon': Icons.lunch_dining,
    'color': Colors.orange,
    'label': '食事',
  },
  {
    'icon': Icons.local_drink,
    'color': Colors.blue,
    'label': '飲み物',
  },
  {
    'icon': Icons.icecream,
    'color': Colors.lightGreen,
    'label': '菓子類',
  },
  {
    'icon': Icons.star,
    'color': Colors.green,
    'label': 'その他',
  },
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
          itemCount: choicesLists.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  final temporaryList = ref.read(temporaryListNotifierProvider.notifier);
                  temporaryList.updateState([
                    choicesLists[index]['label'],
                    choicesLists[index]['icon'],
                    choicesLists[index]['color']
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
                          ? choicesLists[index]['color']
                          : null,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: choicesLists[index]['color']),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(choicesLists[index]['icon'],
                          color: selectedIndex == index
                            ? Colors.white
                            :  choicesLists[index]['color']),
                          const SizedBox(width: 4.0),
                          Text(
                            choicesLists[index]['label'],
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

