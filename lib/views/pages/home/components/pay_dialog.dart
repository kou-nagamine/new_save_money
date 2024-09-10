import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';
import 'package:new_save_money/views/pages/home/providers/save.dart';

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
        height: 300,
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
                    fontSize: 16, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: changedLogs.length,
                itemBuilder: (context, index) {
                  final log = changedLogs[index];
                  return ListTile(
                    title: Text('ログ名: ${log.name}'),
                    subtitle: Text(
                      log.status == SaveStatus.inUse
                          ? '使用額: ${log.usedAmount} / ${log.price} 円'
                          : '使用額: ${log.usedAmount}円',
                    ),
                  );
                },
              ),
            ),
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