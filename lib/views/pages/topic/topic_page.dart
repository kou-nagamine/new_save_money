import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/card_view.dart';

//スライドショーの画像
final images = [
      "assets/images/jtb.png",
      "assets/images/kinki_tourist.png",
      "assets/images/rakuten_travel.png"
      ];

//TopicPageの全体
class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {   
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                HeaderWidget(images: images),
                const _TabBar(),
              ];
            },
            body: const TabBarView(
              children: [
                RecomendCardView(),
                NomalCardView(),
                NomalCardView(),
              ],
            ),
          ),
        ),
      )
    );
  }
}

//TopicPageのスライドショー
class HeaderWidget extends StatelessWidget {
  final List<String> images;
  final double height;

  HeaderWidget({required this.images, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 1.0, keepPage: true);
    final double screenWidth = MediaQuery.of(context).size.width;

    //
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

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: height,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (_, index) {
                return pages[index % pages.length];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyTabBarDelegate(
        tabBar: ButtonsTabBar(
          backgroundColor: Colors.black,
          unselectedBackgroundColor: Colors.transparent,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          height: 55.0,  // ボタンの高さを指定
          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),  // コンテンツのパディングを指定
          buttonMargin: const EdgeInsets.only(top: 10, bottom: 10, left: 35.0, right: 35.0),
          radius: 15,
          tabs: const [
            Tab(
              text:"学習"
            ),
            Tab(
              text:"楽しむ"
            ),
            Tab(
              text:"その他"
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({required this.tabBar});

  final PreferredSizeWidget tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}