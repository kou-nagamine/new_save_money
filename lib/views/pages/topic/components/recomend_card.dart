import 'package:flutter/material.dart';
import 'package:new_save_money/views/pages/topic/topic_page.dart';

import '../components/topic_content.dart';

class RecomendCard extends StatelessWidget {
  const RecomendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Material(
          color: Colors.transparent,  // Materialの背景色を透明に設定
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TopicContent()),
              // );
          },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
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
                                fontSize: 22,
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
                                fontSize: 16,
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
      )
    );
  }
}