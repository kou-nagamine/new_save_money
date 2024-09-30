import 'package:flutter/material.dart';
import 'package:new_save_money/view/expense_list.dart/components/nomal_card.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

//NormalCardのPageView
class NomalCardView extends StatelessWidget {
  const NomalCardView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<cloud_firestore.QuerySnapshot>(
      stream: cloud_firestore.FirebaseFirestore.instance
      .collection('topic_content')
      .where('category', isEqualTo: category)
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        var documents = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // 2列のグリッドに設定
            mainAxisSpacing: 0.0,  // 縦方向のスペース
            crossAxisSpacing: 0.0,  // 横方向のスペース
            childAspectRatio: 0.75,  // カードの縦横比を調整（必要に応じて変更）
          ),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            var data = documents[index].data() as Map<String, dynamic>;
            var imageUrl = data['image_url'];
              return  NomalCard(
                index: index,
                title: data['title'],
                description: data['description'],
                imageUrl: imageUrl,
                );
          },
        );
      },
    );
  }
}
