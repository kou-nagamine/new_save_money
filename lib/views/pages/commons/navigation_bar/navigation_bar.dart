//packages
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//dart
import 'dart:ui';

//pages
import '/views/pages/setting/setting_page.dart';
import '/views/pages/home/home_page.dart';
import '/views/pages/calculator/calculator_page.dart';
//import '/views/pages/topic/topic_page.dart';



class CommonNavigationBar extends StatelessWidget {
  final int initialIndex;

  const CommonNavigationBar({super.key, this.initialIndex = 0});//初期値を設定  0:home 1:calculator 2:setting　0以外を設定する場合は、各自で設定してください　by H 

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget(initialIndex: initialIndex);
  }
}

class MyStatefulWidget extends StatefulWidget {
  final int initialIndex;

  const MyStatefulWidget({super.key, required this.initialIndex});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late int selectedIndex;
  bool isBottomNavVisible = true; // BottomNavigationBar の表示状態を管理

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    isBottomNavVisible = selectedIndex != 1; // 初期化時に記録ページでなければ表示
  }

  final _screens = [
    HomePage(),
    null,
    SettingPage(),
  ];

// BottomNavigationBar cululatorのタップ時の処理
void _onItemTapped(int index) {
  if (index == 1) {
    showCupertinoModalBottomSheet( // モーダルシートで表示
      context: context,
      expand: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CalculatorPage(),
    );
  } else {
    setState(() {
      selectedIndex = index;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: selectedIndex == 1 ? Container() : _screens[selectedIndex],
      bottomNavigationBar: isBottomNavVisible
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Wallet(width: 30),
                        activeIcon: Wallet(width: 30, color: Colors.blue),
                        label: 'おかね',
                        tooltip: "This is a Home Page",
                      ),
                      BottomNavigationBarItem(
                        icon: PlusCircle(width: 30),
                        activeIcon: PlusCircle(width: 30, color: Colors.blue),
                        label: '記録',
                        tooltip: "This is a History Page",
                      ),
                      BottomNavigationBarItem(
                        icon: FavouriteBook(width: 30),
                        activeIcon: FavouriteBook(width: 30, color: Colors.blue),
                        label: 'トピック',
                        tooltip: "This is a Catalog Page",
                      ),
                    ],
                    type: BottomNavigationBarType.fixed,
                    iconSize: 18,
                    selectedFontSize: 10,
                    selectedIconTheme: IconThemeData(size: 30, color: Colors.blue),
                    selectedLabelStyle: TextStyle(color: Colors.blue),
                    selectedItemColor: Colors.blue,
                    unselectedFontSize: 10,
                    unselectedIconTheme: IconThemeData(size: 30, color: Colors.black.withOpacity(0.7)),
                    unselectedItemColor: Colors.black,
                  ),
                ),
              ),
            )
          : null, // BottomNavigationBar を非表示
    );
  }
}
