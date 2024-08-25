import 'package:flutter/material.dart';

import '../components/topic_content.dart';

class NomalCard extends StatelessWidget {
  const NomalCard({required this.index,super.key});
    final int index;  // インデックスを保持

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Material(
        color: Colors.transparent,  // Materialの背景色を透明に設定
        child: InkWell(
          onTap: () {
             navigateWithCustomTransition(context);
            //  Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => TopicContent(index: index)),
            //   );
          },
          child: Hero(
            tag: 'card-hero-$index',
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              return Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    toContext.widget, // アニメーション中は、移動先のウィジェットをそのまま表示
                  ],
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      image: DecorationImage(
                        image: AssetImage('assets/images/AI_image.jpeg'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9), // 90%の不透明度の黒
                            Colors.white.withOpacity(0.1), // 白
                          ],
                          stops: [0, 1], // 黒が85%の位置で終了し、残りは白
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'タイトル',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                shadows: [
                                  Shadow(blurRadius: 8.0),
                                ],
                              ),
                            ),
                            Text(
                              'ここに説明文が入ります',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                shadows: [
                                  Shadow(blurRadius: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
  // カスタムページ遷移アニメーション
  void navigateWithCustomTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TopicContent(index: index),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);  // 下から上にスライド
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 700),  // アニメーションの長さ
      ),
    );
  }
}
