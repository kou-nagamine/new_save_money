import 'package:flutter/material.dart';

import '../components/topic_content.dart';

class NomalCard extends StatelessWidget {
  const NomalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Material(
        color: Colors.transparent,  // Materialの背景色を透明に設定
        child: InkWell(
          onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TopicContent()),
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
        ),
      ),
    );
  }
}