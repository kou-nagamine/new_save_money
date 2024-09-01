import 'package:flutter/material.dart';
import '../components/topic_content.dart';

//firebase
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

//Storageに保存した画像のURLを取得する際のコード
class NetworkImageBuilder extends FutureBuilder {
  NetworkImageBuilder(Future<String> item)
  :item = item,
  super(
    future: item,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: const Center(child: Icon(Icons.error, color: Colors.red)),
        );
      } else if (snapshot.hasData) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
            image: DecorationImage(
              image: NetworkImage(snapshot.data!),
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: const Center(child: Icon(Icons.error)),
        );
      }
    },
  );
  final Future<String> item;
}



class NomalCard extends StatelessWidget {
  final int index;  // インデックスを保持
  final String title;
  final String description;
  final String imageUrl;

  const NomalCard({
    required this.index,
    required this.title,
    required this.description,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Material(
        color: Colors.transparent,  // Materialの背景色を透明に設定
        child: InkWell(
          onTap: () {
             navigateWithCustomTransition(context);
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
            child:  Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  NetworkImageBuilder(
                    firebase_storage.FirebaseStorage.instance
                        .ref(imageUrl)
                        .getDownloadURL(),
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
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
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
                              description,
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
            )
          )
        ),
      ),
    );
  }
  // カスタムページ遷移アニメーション
  void navigateWithCustomTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TopicContent(index: index, imageUrl: imageUrl, description: description, title: title),
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
