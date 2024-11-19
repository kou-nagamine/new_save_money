import 'package:flutter/material.dart';
import '../../expense_record/expencse_record_page.dart';

//firebase
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';

//Storageに保存した画像のURLを取得する際のコード
class NetworkImageBuilder extends StatelessWidget {
  final String imageUrl;

  NetworkImageBuilder(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl), // CachedNetworkImageProviderを使用
          fit: BoxFit.fitHeight, // 画像をフィットさせる
        ),
      ),
    );
  }
}

class NomalCard extends StatefulWidget {
  final int index;  // インデックスを保持
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  


  const NomalCard({
    required this.index,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    super.key,
  });

  @override
  _NomalCardState createState() => _NomalCardState();
  }

  class _NomalCardState extends State<NomalCard> {
    String? fetchedImageUrl;
    bool _isFetching = false; 

    @override
    void initState() {
      super.initState();
      _fetchImageUrl();
    }

    Future<void> _fetchImageUrl() async {
      if (fetchedImageUrl != null || _isFetching) return;
    
      setState(() {
        _isFetching = true;
      });

      try {
        final url = await firebase_storage.FirebaseStorage.instance
          .ref(widget.imageUrl)
          .getDownloadURL();

        setState(() {
          fetchedImageUrl = url;
        });
      } catch (e) {
        // エラーハンドリング
         setState(() {
          _isFetching = false;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    final heroTag = '${widget.category}-${widget.index}';
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Material(
        color: Colors.transparent,  // Materialの背景色を透明に設定
        child: InkWell(
          onTap: () {
            // fetchedImageUrlがnullの場合にデフォルト値を設定
            final imageToUse = fetchedImageUrl ?? '';
            navigateWithCustomTransition(context, heroTag, imageToUse);
          },
          child: Hero(
            tag: heroTag,
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              return Material(
                child: Stack(
                  children: [
                    fromContext.widget, // 遷移元のウィジェット
                    toContext.widget,   // 遷移先のウィジェット
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
                   fetchedImageUrl == null
                      ? Center(child: CircularProgressIndicator()) // 画像取得中のプレースホルダー
                      : CachedNetworkImage(
                          imageUrl: fetchedImageUrl!,          
                          errorWidget: (context, url, error) => Icon(Icons.error), // エラー時のアイコン
                          fit: BoxFit.cover, 
                          width: double.infinity,
                          height: double.infinity,
                        ),
                  Container(
                    width: double.infinity, 
                    height: double.infinity, 
                    child: fetchedImageUrl != null // すでに取得済みのURLがあるかどうかを確認
                    ? CachedNetworkImage(
                      imageUrl: fetchedImageUrl!,
                      fadeInDuration: Duration.zero, 
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.grey[500]),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: const Center(child: Icon(Icons.error, color: Colors.red)),
                      ),
                    )
                  : Container( // 初回ロード中の表示
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9), // 90%の不透明度の黒
                            Colors.white.withOpacity(0.01), // 白
                          ],
                          stops: [0, 1], 
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
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
                              widget.description,
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
  void navigateWithCustomTransition(BuildContext context, String heroTag, String imageUrl) {
    precacheImage(CachedNetworkImageProvider(imageUrl), context); 
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TopicContent(index: widget.index, imageUrl: imageUrl, description: widget.description, title: widget.title, heroTag: heroTag,),
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
