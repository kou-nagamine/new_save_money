import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:iconoir_flutter/iconoir_flutter.dart';
import '/views/pages/setting/setting_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0085FF),
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final _screens = [
    SettingPage(),
    SettingPage(), // 各自で作成したページに変更してください
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: _screens[_selectedIndex],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
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
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Wallet(width: 40),
                        activeIcon:  Wallet(width: 40 , color: Colors.blue,),
                        label: 'おかね',
                        tooltip: "This is a Home Page",
                      ),
                      BottomNavigationBarItem(
                        icon: PlusCircle(width: 40,),
                        activeIcon:PlusCircle(width: 40,color: Colors.blue,),
                        label: '記録',
                        tooltip: "This is a History Page",
                      ),
                      BottomNavigationBarItem(
                        icon: FavouriteBook( width: 40,),
                        activeIcon: FavouriteBook( width: 40,color: Colors.blue,),
                        label: 'トピック',
                        tooltip: "This is a Catalog Page",
                      ),
                      
                    ],
                    type: BottomNavigationBarType.fixed,
                    iconSize: 18,
                    selectedFontSize: 14,
                    selectedIconTheme: IconThemeData(size: 40, color: Colors.blue),
                    selectedLabelStyle: TextStyle(color: Colors.blue),
                    selectedItemColor: Colors.blue,
                    unselectedFontSize: 14,
                    unselectedIconTheme: IconThemeData(size: 40, color: Colors.black.withOpacity(0.7)),
                    unselectedItemColor: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
