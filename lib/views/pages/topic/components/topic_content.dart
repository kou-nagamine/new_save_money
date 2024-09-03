//package
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//components
import 'custom_form.dart';
//pages
import '/views/pages/commons/navigation_bar/navigation_bar.dart';
//providers
import "/views/pages/home/providers/user_log.dart";
import '/views/pages/topic/providers/temporary_topic_list.dart';
import '/views/pages/calculator/providers/all_price.dart';
//freezed
import '/views/pages/home/providers/save.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TopicContent extends ConsumerStatefulWidget{
  const TopicContent({
    required this.index, 
    required this.imageUrl,
    required this.title,
    required this.description,
    super.key
    });
  final int index;  // インデックスを受け取る
  final String imageUrl;
  final String title;
  final String description;



  @override
  _TopicContentState createState() => _TopicContentState();
}

class _TopicContentState extends ConsumerState<TopicContent> {
  @override
  Widget build(BuildContext context) {
    final temporaryTopicList = ref.watch(temporaryTopicListNotifierProvider);
    // ボタンを押せるかどうかを判定
    // final isButtonEnabled = temporaryTopicList[0] != null && temporaryTopicList[1] != null;
    final isButtonEnabled = true;
    final allPriceNotifier = ref.read(allPriceNotifierProvider.notifier);
    final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
    final temporaryTopicListNotifier = ref.read(temporaryTopicListNotifierProvider.notifier);

    return Scaffold(
      body: DraggableHome(
        leading: IconButton(  // 戻るボタン ここでカスタム出来ます。
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            temporaryTopicListNotifier.resetState();
          },
        ),
        curvedBodyRadius: 0,
        title: Text("出費の記録", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context,widget.imageUrl,widget.title,widget.description ), // Custom header
        headerExpandedHeight: 0.5,
        body: [
          CustomForm(),
        ],
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: isButtonEnabled ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonNavigationBar()),
                );
                // Saveクラスのインスタンスを作成
                final save = Save(
                  name: temporaryTopicList[0] ?? widget.title, // カテゴリ名
                  price: temporaryTopicList[1] ?? 1500, // 価格
                  icon: Icons.local_activity, // カテゴリアイコン
                  color: Color(0xffE82929), // カテゴリカラー
                  payment: false, 
                  dataTime: "",// 必要に応じて true または false に設定
                  memo: ""
                );
                userLogNotifier.updateState(save);
                temporaryTopicListNotifier.resetState();
                allPriceNotifier.subtractPrice(temporaryTopicList[1]);
              }
              : null,
              child: Text('割り当てる', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              backgroundColor: isButtonEnabled ? Color(0xff005BEA) : Colors.grey,
              elevation: 10,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        fullyStretchable: false,
        backgroundColor: Colors.white,
        appBarColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
      ),
    );
  }

  Widget headerWidget(BuildContext context,  String imageUrl, String title, String description) {
    final temporaryTopicListNotifier = ref.read(temporaryTopicListNotifierProvider.notifier);
    return Hero(
      tag: 'card-hero-${widget.index}',
      child: FutureBuilder<String>(
        future: firebase_storage.FirebaseStorage.instance
            .ref(imageUrl)
            .getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.6,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.error, color: Colors.red)),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:  NetworkImage(snapshot.data!),
                      fit: BoxFit.cover, // 画像を全体にカバー
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9), // 90%の不透明度の黒
                        Colors.white.withOpacity(0), // 白
                      ],
                      stops: [0.1, 1], // 黒が85%の位置で終了し、残りは白
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Text(
                              //   description,
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context); // 前のページに戻る
                      temporaryTopicListNotifier.resetState();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_rounded,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.error)),
            );
          }
        },
      ),
    );
  }
}
