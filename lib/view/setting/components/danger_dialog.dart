import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:new_save_money/view/walkthrough/pageview.dart';

import 'package:new_save_money/view_model/user_log.dart';
import 'package:new_save_money/view_model/all_price.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

class DangerDialog extends ConsumerStatefulWidget{

  const DangerDialog({Key? key,}): super(key: key);

    @override
  _DangerDialogState createState() => _DangerDialogState();
}
class _DangerDialogState extends ConsumerState<DangerDialog> with SingleTickerProviderStateMixin {
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
    return PopScope(
      canPop: false,
      child:AlertDialog(
        contentPadding: const EdgeInsets.all(15),
        content:  SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/error.json',
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
                child: Center(
                  child:  Text('この操作は２度と元にもどせません。',
                    style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ボタン間にスペースを均等に配置
            children: [
              TextButton(
                onPressed: () async{
                  try {
                    ref.read(userLogNotifierProvider.notifier).resetLogs();
                    ref.read(allPriceNotifierProvider.notifier).resetPreferences();
                    final prefs = await SharedPreferences.getInstance(); // チュートリアルを削除する
                    await prefs.remove('tutorial');
                    await prefs.remove('DefaultTransactionSwitch');
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageViewWidget(),
                        ),
                      );
                    }
                  } catch (e) {
                    // エラーハンドリング（例えば、ダイアログを表示するなど）
                    print('Error: $e');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 70,
                  decoration: ShapeDecoration(
                    color: Color(0xffd1242f),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 0.6),
                    )),
                  child: const Text(
                    '削除',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // "いいえ" ボタンを押したらポップアップを閉じる
                },
                child: const Text(
                  'やめる',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}