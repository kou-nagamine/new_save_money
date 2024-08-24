import 'package:flutter/material.dart';
import 'package:new_save_money/views/pages/topic/components/nomal_card.dart';
import 'package:new_save_money/views/pages/topic/components/recomend_card.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {   
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                HeaderWidget(images: images),
                const _TabBar(),
              ];
            },
            body: TabBarView(
              children: [
                RecomendCardView(),
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

final images = [
      "assets/images/jtb.png",
      "assets/images/kinki_tourist.png",
      "assets/images/rakuten_travel.png"
      ];

class HeaderWidget extends StatelessWidget {
  final List<String> images;
  final double height;

  HeaderWidget({required this.images, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 1.0, keepPage: true);
    final double screenWidth = MediaQuery.of(context).size.width;

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

class RecomendCardView extends StatelessWidget {
  const RecomendCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // 全体のパディングを設定
      child: ListView(
        children: const [
          RecomendCard(),
          SizedBox(height: 16), // 各カードの間にスペースを追加
          RecomendCard(),
          SizedBox(height: 16),
          RecomendCard(),
          SizedBox(height: 16),
          RecomendCard(),
        ],
      ),
    );
  }
}


class NomalCardView extends StatelessWidget {
  const NomalCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // 2列のグリッドに設定
        mainAxisSpacing: 16.0,  // 縦方向のスペース
        crossAxisSpacing: 16.0,  // 横方向のスペース
        childAspectRatio: 0.75,  // カードの縦横比を調整（必要に応じて変更）
      ),
      itemCount: 10,  // 表示するカードの数
      itemBuilder: (context, index) {
        return const NomalCard();
      },
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: _StickyTabBarDelegate(
        tabBar: TabBar(
          tabs: [
            Tab(
              child: Icon(
                Icons.grid_on_sharp,
                color: Colors.black,
              ),
            ),
            Tab(
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            ),
            Tab(
              child: Icon(
                Icons.add_card,
                color: Colors.black,
              ),
            ),
            Tab(
              child: Icon(
                Icons.supervisor_account_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

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