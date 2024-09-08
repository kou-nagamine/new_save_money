import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:new_save_money/views/pages/commons/navigation_bar/navigation_bar.dart';


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
                  Text('今回の800円のお買い物では下記の我慢によって節約できました!',
                   style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
            child: const Text('閉じる',
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