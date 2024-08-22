import 'package:flutter/material.dart';
import 'package:new_save_money/views/pages/topic/components/recomend_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
class TopicPage extends StatelessWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,  // タブの数
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(""),
                  background: headerWidget(context),
                  centerTitle: true,
                  stretchModes: [StretchMode.zoomBackground],
                  collapseMode: CollapseMode.pin,
                ),
                bottom: buildHeaderBottomBar(), // ここでTabBarをAppBarに追加
              ),
              SliverFillRemaining(
                child: buildTabBarView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    final controller = PageController(viewportFraction: 1.0, keepPage: true);
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
            fit: BoxFit.cover,
            width: screenWidth,
          ),
        ),
      ),
    );
    return Container(
      height: 200,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (_, index) {
          return pages[index % pages.length];
        },
      ),
    );
  }

  PreferredSizeWidget buildHeaderBottomBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: ButtonsTabBar(
        backgroundColor: Colors.black,
        borderWidth: 2,
        borderColor: Colors.black,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedBackgroundColor: Colors.transparent,
        unselectedBorderColor: Colors.transparent,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        radius: 100,
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        buttonMargin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        tabs: const [
          Tab(text: "Tab 1"),
          Tab(text: "Tab 2"),
          Tab(text: "Tab 3"),
          Tab(text: "Tab 4"),
        ],
      ),
    );
  }

  Widget buildTabBarView() {
    return TabBarView(
      children: [
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Column(
                children: [
                  RecomendCard(),
                  RecomendCard(),
                ],
              ),
            ),
          ],
        ),
        Center(child: Text("Content for Tab 2")),
        Center(child: Text("Content for Tab 3")),
        Center(child: Text("Content for Tab 4")),
      ],
    );
  }
}