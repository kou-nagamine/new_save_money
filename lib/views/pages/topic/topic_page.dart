import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    final images = [
      "assets/images/jtb.png",
      "assets/images/kinki_tourist.png",
      "assets/images/rakuten_travel.png"
    ];

    final pages = List.generate(
      images.length,
      (index) => Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,  // 画像の表示方法を調整（必要に応じて変更可能）
            width: screenWidth,
          ),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:20),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: controller,
                // itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SizedBox(height: 8),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                type: WormType.thinUnderground,
              ),
            ),
            SizedBox(height:15),
            Expanded(
              child: DefaultTabController(
                length: 4,  // タブの数
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      backgroundColor: Colors.black,
                      borderWidth: 2,
                      borderColor: Colors.black,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedBackgroundColor: Colors.transparent,  // 背景色を透明に設定
                      unselectedBorderColor: Colors.transparent,  
                      unselectedLabelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      radius: 100,
                      contentPadding: EdgeInsets.symmetric(horizontal: 25),
                      buttonMargin: EdgeInsets.symmetric( vertical: 5.0,horizontal: 10),
                      tabs: const [ 
                        Tab(text: "Tab 1",),
                        Tab(text: "Tab 2"),
                        Tab(text: "Tab 3"),
                        Tab(text: "Tab 4"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: Text("Content for Tab 1"),
                          ),
                          Center(child: Text("Content for Tab 2")),
                          Center(child: Text("Content for Tab 3")),
                          Center(child: Text("Content for Tab 4")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}