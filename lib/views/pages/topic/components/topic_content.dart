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

class TopicContent extends ConsumerStatefulWidget {
  const TopicContent({super.key});

  @override
  _TopicContentState createState() => _TopicContentState();
}

class _TopicContentState extends ConsumerState<TopicContent> {
  String _title = 'サークル会食';
  int _amount = 700;
  DateTime _date = DateTime.now();
  String _memo = '';

  void _onFormChanged(String title, int amount, DateTime date, String memo) {
    setState(() {
      _title = title;
      _amount = amount;
      _date = date;
      _memo = memo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableHome(
        title: Text("出費の記録", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context), // Custom header
        headerExpandedHeight: 0.45,
        body: [
          CustomForm(
            onFormChanged: _onFormChanged, 
          ),
        ],
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child:  FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonNavigationBar()),
                );
                final userLogNotifier = ref.read(userLogNotifierProvider.notifier);
                userLogNotifier.updateState({
                  // カテゴリ名を設定。categoryDataがnullでなく、かつ空でない場合はcategoryDataの最初の要素を使用。それ以外はデフォルトで'飲み物'を使用
                  'categoryName': _title,
                  // カテゴリアイコンを設定。categoryDataがnullでなく、かつ2つ以上の要素がある場合はcategoryDataの2番目の要素を使用。それ以外はデフォルトでIcons.local_drinkを使用
                  'categoryIcon': Icons.local_activity,
                  // カテゴリカラーを設定。categoryDataがnullでなく、かつ3つ以上の要素がある場合はcategoryDataの3番目の要素を使用。それ以外はデフォルトでColors.blackを使用
                  'color': Color(0xffE82929),
                  // 価格を設定。チャージ状態を整数に変換して設定
                  'price': _amount,
                  // 日付を設定。現在の日時を設定
                  "date" : _date,
                  // メモを設定。categoryDataがnullでなく、かつ空でない場合はcategoryDataの最初の要素を使用。それ以外はデフォルトで'飲み物'を使用
                  "memo" :  _memo,
                  // 目的を設定。デフォルトで'入金'を使用
                  "purpose" : "出金",
                });
              },
              child: Text('割り当てる', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              backgroundColor: Color(0xff005BEA),
              elevation: 0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        fullyStretchable: false, 
        backgroundColor: Colors.white,
        appBarColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white, 
      )
    );
  }

  Widget headerWidget(BuildContext context) {
    return Stack( 
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/kinki_tourist.png'),
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
    );
  }
}
