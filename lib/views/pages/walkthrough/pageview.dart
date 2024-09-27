//package
import 'dart:async';
import 'package:flutter/material.dart';

//commons
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget>  with TickerProviderStateMixin{
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageViewController,
                onPageChanged: _handlePageViewChanged,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 150, 20, 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ついで口座',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(height: 50),
                        Image.asset(
                          'assets/images/walkthrough.png', 
                          width: MediaQuery.of(context).size.width * 0.8, 
                          fit: BoxFit.cover, 
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 100),                   
                        Text('日々のついで出費を記録', 
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          )
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '生活するうえでどちらかといえば必要じゃない出費を', 
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5B5B5B)
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\n日々の我慢した金額をアプリに記録しよう！', 
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5B5B5B)
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 100),                   
                        Text('グラフで見える化', 
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          )
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'グラフや履歴で、自分のついで残高の進捗を確認しよう！', 
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5B5B5B)
                            ),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: '\n日々の我慢した金額をアプリに記録しよう！', 
                            //     style: TextStyle(
                            //       fontSize: 16, 
                            //       fontWeight: FontWeight.bold,
                            //       color: Color(0xff5B5B5B)
                            //     )
                            //   ),
                            // ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 100),                   
                        Text('貯めた残高で出費に割り当てよう', 
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          )
                        ),
                        SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '今までのついで出費で必要な出費がお得に！', 
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5B5B5B)
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\nコツコツ記録して貯金をはじめよう!', 
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5B5B5B)
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PageIndicator(
                tabController: _tabController,
                currentPageIndex: _currentPageIndex,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0),
                width: double.infinity,
                child:  FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () async{
                    final prefs = await SharedPreferences.getInstance();
                    if (_currentPageIndex < 3) {
                      _updateCurrentPageIndex(_currentPageIndex + 1);
                    } else {
                      prefs.setBool('tutorial', true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonNavigationBar()
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentPageIndex < 3 ? '続ける' : 'はじめる',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Color(0xff005BEA),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: TabPageSelector(
          controller: tabController,
          selectedColor: Color(0xff0071FF),
        ),
      ),
    );
  }
}
