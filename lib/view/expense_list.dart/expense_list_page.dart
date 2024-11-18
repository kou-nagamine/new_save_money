import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'components/card_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

Future<List<String>> fetchImageUrls() async {
  final ListResult result = await FirebaseStorage.instance.ref('slideshow').listAll();
  final List<String> urls = await Future.wait(result.items.map((item) => item.getDownloadURL()).toList());
  return urls;
}
// //スライドショーの画像
// final images = [
//       "assets/images/lounas.png",
//       "assets/images/zenn.png",
//       "assets/images/tuide-tester-poster.png",
//       ];

final labels = [
  "学習",
  "楽しむ",
  "その他",
];    

//TopicPageの全体
class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: labels.length,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                FutureBuilder<List<String>>(
                  future: fetchImageUrls(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: Text('スライドショーの画像を取得できませんでした。'),
                          ),
                        ),
                      );
                    }
                    return HeaderWidget(images: snapshot.data!);
                  },
                ),
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
                          "おかねを使う", // タイトルを追加
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "好きなことや必要なことに今までのついで収入を\n使って記録しよう！", // サブタイトル
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
                NomalCardView(category: '勉強'),
                NomalCardView(category: '楽しむ'),
                NomalCardView(category: 'その他'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//TopicPageのスライドショー
class HeaderWidget extends StatefulWidget {
  final List<String> images;
  final double height = 200;

  HeaderWidget({required this.images});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
  }

  class _HeaderWidgetState extends State<HeaderWidget> {
    late PageController _controller;
    Timer? _timer;
    int _currentPage = 0;
    static const int _initialPage = 1000; // 初期ページを非常に大きな数に設定

    @override
    void initState() {
      super.initState();
      _controller = PageController(
        viewportFraction: 1.0,
        keepPage: true,
        initialPage: _initialPage, // 初期ページを指定
      );
      _currentPage = _initialPage;
      // 自動スライドのタイマーを開始
      if (widget.images.length > 1) {
        _startAutoSlideTimer();
      }
    }

    // 自動スライドを開始するタイマーを設定
    void _startAutoSlideTimer() {
      _timer?.cancel(); // 既存のタイマーをキャンセル
      _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
        _currentPage++;
        _controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
    void _resetAutoSlideTimer() {
      _timer?.cancel(); // 既存のタイマーをキャンセル
      _timer = Timer(Duration(seconds: 2), () {
        _startAutoSlideTimer(); // 3秒後に自動スライドを再開
      });
    }

    @override
    void dispose() {
      _controller.dispose();
      _timer?.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      // 画像が1枚の場合の処理
      if (widget.images.length == 1) {
        return SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.width * 9 / 16, // 16:9のアスペクト比に基づいて高さを指定
            child: Image.network(
              widget.images[0],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }

      // 画像が複数の場合の処理
      return SliverToBoxAdapter(
        child: Container(
          height: MediaQuery.of(context).size.width * 9 / 16, // 16:9のアスペクト比に基づいて高さを指定
          child: GestureDetector(
            onPanDown: (_) {
              _resetAutoSlideTimer(); // 3秒後に自動スライドを再開するためにタイマーをリセット
            },
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.images.length, // 画像の数を指定
              itemBuilder: (_, index) {
                return Image.network(
                  widget.images[index], // 画像のインデックスをそのまま使用
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
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