import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart'as iconoir;
import 'custom_form.dart';


class TopicContent extends StatelessWidget{
  const TopicContent({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableHome(
        title: Text("引き換え", style: TextStyle(fontWeight: FontWeight.bold)),  
        headerWidget: headerWidget(context),  // Custom header
        headerExpandedHeight: 0.45,
        body: [
          CustomForm(),
        ],
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child:  FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                print('押された時に金額を差し引く');
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
