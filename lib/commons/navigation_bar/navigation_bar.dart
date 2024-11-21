//packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

//dart
import 'dart:ui' as ui;

//pages
//import '/views/pages/setting/setting_page.dart';
import '../../view/bank_acount/bank_acount_page.dart';
import '../../view/tuide_income_record/tuide_income_page.dart';
import '../../view/expense_list.dart/expense_list_page.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

class CommonNavigationBar extends StatelessWidget {
  final int initialIndex;
 const CommonNavigationBar({Key? key, this.initialIndex = 0}) : super(key: key);//初期値を設定  0:home 1:calculator 2:setting　0以外を設定する場合は、各自で設定してください　by H 

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
  static bool _isFirstLaunch = true;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    isBottomNavVisible = selectedIndex != 1; // 初期化時に記録ページでなければ表示
     _loadPreferences();
  }

  // SharedPreferences から初期データを読み込み
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultTransaction = prefs.getBool('DefaultTransactionSwitch') ?? false;
    if (_isFirstLaunch && selectedIndex == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isFirstLaunch = false;
      // デフォルト設定にしているのかどうかを判定
      if (defaultTransaction == true && mounted) {
        setState(() {
          // 初回起動でホーム画面なら記録ページに移動
          _onItemTapped(1);
        });
      }
      });
    }
  }

  final _screens = [
    HomePage(),
    null, // CalculatorPage はモーダルで表示されるのでnull
    const TopicPage(),
  ];

    final _buttonNames = ['こうざ', 'ついで', 'つかう'];

  // BottomNavigationBar cululatorのタップ時の処理
  void _onItemTapped(int index) {
    if (index == 1) {
      showBarModalBottomSheet( // モーダルシートで表示
        context: context,
        expand: true,
        backgroundColor: Colors.transparent,
        builder: (context) => CalculatorPage(),
     ).then((_) {
      // モーダルが閉じられたときにステータスバーの色をリセット
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: ui.Brightness.light,  // iOS用
          statusBarIconBrightness: ui.Brightness.dark,  // Android用
        ),
      );
    });
    // モーダルが表示される時のステータスバー設定
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: ui.Brightness.dark,  // モーダルが表示されたときのiOS用
        statusBarIconBrightness: ui.Brightness.light,  // Android用
      ),
    );
  } else {
    setState(() {
      selectedIndex = index;
    });
    // ナビゲーション変更時にステータスバーの色をリセット
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: ui.Brightness.light,  // iOS用
        statusBarIconBrightness: ui.Brightness.dark,  // Android用
      ),
    );
  }
}
// Analytics用のイベントを記録
 Future<void> _logButtonTapEvent(int index) async {
    final buttonName = _buttonNames[index]; // ボタンの名前を取得
    await _analytics.logEvent(
      name: 'navigation_button_tap',
      parameters: {
        'button_name': buttonName,
        'button_index': index,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: selectedIndex == 1 ? Container() : _screens[selectedIndex],
      bottomNavigationBar: isBottomNavVisible
          ? ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: iconoir.Wallet(width: 30),
                        activeIcon: iconoir.Wallet(width: 30, color: Colors.blue),
                        label: 'こうざ',
                        tooltip: "This is a Home Page",
                      ),
                      BottomNavigationBarItem(
                        icon: iconoir.PlusCircle(width: 30),
                        activeIcon: iconoir.PlusCircle(width: 30, color: Colors.blue),
                        label: 'ついで',
                        tooltip: "This is a History Page",
                      ),
                      BottomNavigationBarItem(
                        icon: iconoir.FavouriteBook(width: 30),
                        activeIcon: iconoir.FavouriteBook(width: 30, color: Colors.blue),
                        label: 'つかう',
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
