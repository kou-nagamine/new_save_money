//package
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../expense_list.dart/components/pay_dialog.dart';
//components
import 'components/custom_form.dart';
//providers
import "../../view_model/user_log.dart";
import '../../view_model/temporary_topic_list.dart';
import '../../view_model/all_price.dart';
//freezed
import '../../model/save.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';


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
    //
    final allPrice = ref.watch(allPriceNotifierProvider);

    // ボタンを押せるかどうかの判定a
    final isButtonEnabled = [temporaryTopicList[4], temporaryTopicList[5], temporaryTopicList[6]].every((item) => item == true) && allPrice[1] != 0;
    //
    final allPriceNotifier = ref.read(allPriceNotifierProvider.notifier);
    final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
    final temporaryTopicListNotifier = ref.read(temporaryTopicListNotifierProvider.notifier);
    

    return Scaffold(
      body: DraggableHome(
        leading: IconButton(  // 戻るボタン ここでカスタム出来ます。
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pop();
            temporaryTopicListNotifier.resetState();
          },
        ),
        curvedBodyRadius: 0,
        title: Text("支出の記録", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context,widget.imageUrl,widget.title,widget.description ), // Custom header
        headerExpandedHeight: 0.5,
        body: [
          CustomForm(
            hinttitle: widget.title,
          ),
        ],
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: EdgeInsets.only(bottom: 0),
            width: double.infinity,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              // buttonを押した時の処理
              onPressed: isButtonEnabled ? () async {
                //イメージのパスを取得
                print(widget.imageUrl);
                
                final currentDateTime = temporaryTopicList[2] ?? DateTime.now();
                int price = temporaryTopicList[1] ?? 1500;
                String memo = temporaryTopicList[3] ?? "メモがありません";
                // allPriceの値を取得して比較
                double salePercentage = allPrice[1]/  price * 100;
                if (salePercentage > 100) {
                  salePercentage = 100;
                }
                if (price > allPrice[1]) {  // ここでtemporaryTopicList[1]とallPrice[1]を比較
                  price = allPrice[1];  // priceがallPriceより大きい場合、allPriceに変更
                }
                // Saveクラスのインスタンスを作成
                final save = Save(
                  name: temporaryTopicList[0] ?? widget.title, // カテゴリ名
                  price: price, // 価格
                  icon: Icons.local_activity, // カテゴリアイコン
                  color: Color(0xffE82929), // カテゴリカラー
                  deposit: false, 
                  dataTime: currentDateTime,// 必要に応じて true または false に設定
                  memo: memo,
                  imageUrl: widget.imageUrl,
                  salePercentage: salePercentage,
                );
                userLogNotifier.updateState(save);
                temporaryTopicListNotifier.resetState();
                allPriceNotifier.subtractPrice(price);
                userLogNotifier.updateLogsBasedOnPrice(price);
                // dialogを表示
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return PayDialog(
                    );
                  },
                );
              } : null,
              child: Text('記録する', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

  // 上記の画像スライドショー
  Widget headerWidget(BuildContext context,  String imageUrl, String title, String description) {
    final temporaryTopicListNotifier = ref.read(temporaryTopicListNotifierProvider.notifier);
    return Hero(
      tag: 'card-hero-${widget.index}',
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
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
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // 前のページに戻る
                    temporaryTopicListNotifier.resetState();
                  },
                  icon: Icon(
                    Icons.arrow_circle_left_rounded,
                    color: Colors.black,
                    weight: 700,
                    size: 50,
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
