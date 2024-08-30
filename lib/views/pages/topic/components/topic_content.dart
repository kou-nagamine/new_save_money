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
//freezed
import '/views/pages/home/providers/save.dart';

class TopicContent extends ConsumerStatefulWidget{
  const TopicContent({required this.index, super.key});
  final int index;  // インデックスを受け取る

  @override
  _TopicContentState createState() => _TopicContentState();
}

class _TopicContentState extends ConsumerState<TopicContent> {
  @override
  Widget build(BuildContext context) {
    final temporaryTopicList = ref.watch(temporaryTopicListNotifierProvider);

    // ボタンを押せるかどうかを判定
    final isButtonEnabled = temporaryTopicList[0] != null && temporaryTopicList[1] != null;

    return Scaffold(
      body: DraggableHome(
        curvedBodyRadius: 0,
        title: Text("出費の記録", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context), // Custom header
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
                final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
                final temporaryTopicList = ref.watch(temporaryTopicListNotifierProvider);
                // Saveクラスのインスタンスを作成
                final save = Save(
                  name: temporaryTopicList[0], // カテゴリ名
                  price: temporaryTopicList[1], // 価格
                  icon: Icons.local_activity, // カテゴリアイコン
                  color: Color(0xffE82929), // カテゴリカラー
                  payment: false, // 必要に応じて true または false に設定
                );
                userLogNotifier.updateState(save);
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

  Widget headerWidget(BuildContext context) {
    return Hero(
      tag: 'card-hero-${widget.index}',
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/AI_image.jpeg'),
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
                        Icon(
                          Icons.local_drink,
                          size: 35,
                          color: Colors.blue[400],
                        ),
                        SizedBox(width: 10),
                        Text(
                          '外食',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
              },
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
