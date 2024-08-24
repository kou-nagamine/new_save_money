import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';


class TopicContent extends StatelessWidget{
  const TopicContent({super.key});

@override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text("急速充電器"),  
      headerWidget: headerWidget(context),  // Custom header
      headerExpandedHeight: 0.4,
      body: [
        Center(
          child: Text('ああああああああああああああああああああああああああああああああああああ'),
        ),
      ],
      fullyStretchable: true, 
      expandedBody: Center(  
        child: Icon(Icons.settings, size: 30),
      ),
      backgroundColor: Colors.white,
      appBarColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white, 
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          '飲み物',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 40),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                                Icons.local_drink,
                                size: 30,
                                color: Colors.blue[400],
                              ),
                              SizedBox(width: 10),
                            Text(
                              '¥100',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        )
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        )
      ]
    );
  }
}
