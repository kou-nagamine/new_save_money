import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:new_save_money/views/pages/home/providers/user_log.dart';

// components
import 'components/payment_contet.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ReferencePage extends ConsumerWidget {

  final String title;
  final int itemIndex;

  const ReferencePage({
    required this.title,
    required this.itemIndex,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);
    // 該当アイテムを取得
    final item = userSaveLog[itemIndex];
    final DateTime date = item.dataTime;
    final int price = item.price;
    final String memo = item.memo;
    final String formattedPercentage =userSaveLog[itemIndex].salePercentage?.toStringAsFixed(1) ?? "0.0" ;

    return Scaffold(
      body: DraggableHome(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("出費の履歴", style: TextStyle(fontWeight: FontWeight.bold)),
        headerWidget: headerWidget(context, ref),
        headerExpandedHeight: 0.5,
        body: [
          PaymentContet(
            date: date,
            price: price,
            compensatingRatio: formattedPercentage,
            memo: memo,
          )
        ],
      ),
    );
  }

  Widget headerWidget(BuildContext context, WidgetRef ref) {
    final userSaveLog = ref.watch(userLogNotifierProvider);
    final item = userSaveLog[itemIndex];
    final String imageUrl = item.imageUrl;

    return FutureBuilder<String>(
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
          return Stack(
            children: [
              Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.error, color: Colors.red)),
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
            ]
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
          );
        } else {
          return Stack(
            children: [
              Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.error, color: Colors.red)),
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
            ]
          );
        }
      },
    );
  }
}
