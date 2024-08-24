import 'package:flutter/material.dart';

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
            // タップされた時の処理
          },
          child: SizedBox(
            width: 100,  // 幅を変更
            height: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      image: DecorationImage(
                        image: AssetImage('assets/images/meisi.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)
                        ),
                        color: Colors.grey.withOpacity(0.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'タイトル',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
      ),
    );
  }
}