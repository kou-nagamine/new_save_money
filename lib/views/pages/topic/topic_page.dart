import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/card_view.dart';
import 'dart:async';

//スライドショーの画像
final images = [
      "assets/images/jtb.png",
      "assets/images/kinki_tourist.png",
      "assets/images/rakuten_travel.png",
      "assets/images/moneyimage.jpeg",
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
                  SliverToBoxAdapter(
                    child: Divider(
                      height: 5,
                      thickness: 5,
                      color: Colors.black12,
                    ),
                  ),
                 SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 80, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "出費を割り当てる",  // タイトルを追加
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),  
                      Text(
                        "大きな出費やちょっとしたご褒美を今まで我慢したお金で割り当てよう!",  // サブタイトル
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                const _TabBar(),
              ];
            },
            body: const TabBarView(
              children: [
                NomalCardView(),
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
class HeaderWidget extends StatefulWidget {
  final List<String> images;
  final double height;

  HeaderWidget({required this.images, this.height = 200});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
  }

  class _HeaderWidgetState extends State<HeaderWidget> {
    late PageController _controller;
    late Timer _timer;
    int _currentPage = 0;

    @override
    void initState() {
      super.initState();
      _controller = PageController(viewportFraction: 1.0, keepPage: true);

      // 自動スライドのタイマーを設定
      _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_currentPage < widget.images.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }

    @override
    void dispose() {
      _controller.dispose();
      _timer.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final controller = PageController(viewportFraction: 1.0, keepPage: true);
      final double screenWidth = MediaQuery.of(context).size.width;

      final pages = List.generate(
        images.length,
        (index) => Container(
          width: screenWidth,
          child: Center(
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
              width: screenWidth,
            ),
          ),
        ),
      );
      return SliverToBoxAdapter(
        child: Container(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            itemBuilder: (_, index) {
              return pages[index];
            },
          ),
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
          unselectedLabelStyle: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w600),
          labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          height: 60.0,  // ボタンの高さを指定
          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),  // コンテンツのパディングを指定
          buttonMargin: const EdgeInsets.only(top: 12, bottom: 12, left: 35.0, right: 35.0),
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