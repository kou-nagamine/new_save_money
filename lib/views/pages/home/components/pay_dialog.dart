import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';
import 'package:new_save_money/views/pages/home/providers/save.dart';
import 'package:intl/intl.dart';

//riverpod
import 'package:new_save_money/views/pages/home/providers/user_log.dart'; 


class PayDialog extends ConsumerStatefulWidget{

  const PayDialog({Key? key,}): super(key: key);

    @override
  _PayDialogState createState() => _PayDialogState();
}
class _PayDialogState extends ConsumerState<PayDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this); // AnimationControllerの初期化
  }

  @override
  void dispose() {
    _controller.dispose(); // AnimationControllerの破棄
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UserLogNotifierのstateを取得
    final userLogs = ref.watch(userLogNotifierProvider);
    // 修正した部分
    final changedLogs = ref.watch(userLogNotifierProvider.notifier).getChangedLogs();

    // 最新のSaveのpriceを取得
    final latestPrice = userLogs.isNotEmpty ? userLogs.first.price : 0;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      content:  SizedBox(
        height: 450,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset(
              'assets/animations/high_five.json',
              controller: _controller, // アニメーションコントローラーを渡す
              onLoaded: (composition) {
                // アニメーションがロードされたら再生を開始する
                _controller
                  ..duration = composition.duration
                  ..forward(); // アニメーションを1回再生
              },
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text('今回の$latestPrice円のお買い物では下記の我慢によって節約できました!',
                   style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: changedLogs.length,
                itemBuilder: (context, index) {
                  final log = changedLogs[index];
                  final categoryName = log.name;
                  final categoryIcon = Icons.category; // 適切なアイコンを使用
                  final color = Colors.blue; // 適切な色を設定
                  final price = log.price;
                  final deposit = log.deposit;
                  final remainingPercentage = log.remainingPercentage;
                  final priceColor = deposit ? Colors.black : Color(0xFFE82929);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(0),
                    decoration: ShapeDecoration(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xffDDDDDD),
                          width: 1.5,
                        ),
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 20,
                          cornerSmoothing: 0.7,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          title: Text(
                            categoryName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Color(0xff3C3C43),
                            ),
                          ),
                          subtitle: Text(
                            "2021/10/10", // 必要に応じて実際の日付に変更
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Color(0xffA4A4A4),
                            ),
                          ),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF1F1F1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categoryIcon,
                              size: 20,
                              color: color,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "¥${NumberFormat("#,###").format(price)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: priceColor,
                                ),
                              ),
                              Opacity(
                                opacity: deposit ? 0.0 : 1.0,
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * (1.0 - remainingPercentage),
                              decoration: ShapeDecoration(
                                color: Color(0xffD9D9D9).withOpacity(0.5), // 灰色で透明なオーバーレイ
                                shape: RoundedRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 20,
                                    cornerSmoothing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommonNavigationBar(initialIndex: 0),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1), // ここでpaddingをカスタマイズ
            ),
            child: const Text('ホームに戻る',
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
          ),
        )
      ],
    );
  }
}