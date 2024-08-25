import 'package:flutter/material.dart';
import 'package:new_save_money/views/pages/topic/components/nomal_card.dart';
import 'package:new_save_money/views/pages/topic/components/recomend_card.dart';

//RecomendCardのPageView
class RecomendCardView extends StatelessWidget {
  const RecomendCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ListView(
        children: const [
          RecomendCard(),
          SizedBox(height: 10), // 各カードの間にスペースを追加
          RecomendCard(),
          SizedBox(height: 10),
          RecomendCard(),
          SizedBox(height: 10),
          RecomendCard(),
        ],
      ),
    );
  }
}

//NormalCardのPageView
class NomalCardView extends StatelessWidget {
  const NomalCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // 2列のグリッドに設定
        mainAxisSpacing: 0.0,  // 縦方向のスペース
        crossAxisSpacing: 0.0,  // 横方向のスペース
        childAspectRatio: 0.75,  // カードの縦横比を調整（必要に応じて変更）
      ),
      itemCount: 10,  // 表示するカードの数
      itemBuilder: (context, index) {
        return const NomalCard();
      },
    );
  }
}
