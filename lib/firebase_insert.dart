import 'package:cloud_firestore/cloud_firestore.dart';

class  DataInsert{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> insertData() async {
    await _firestore.collection('topic_content').add({
      'category': '勉強',
      'title': 'サブスク',
      'description': '定期的な支払いに割り当てよう',
      'image_url': 'study/copilot.jpeg',
    });
     await _firestore.collection('topic_content').add({
      'category': '勉強',
      'title': 'デバイス',
      'description': '新しいデバイスで学習効率を上げよう',
      'image_url': 'study/macbook.jpeg',
    });
     await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': 'テーマパーク',
      'description': '楽しい思い出を作ろう',
      'image_url': 'enjoy/amusement_park.jpeg',
    });
     await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': '旅行',
      'description': '新しい場所を探検しよう',
      'image_url': 'enjoy/travel.webp',
    });
     await _firestore.collection('topic_content').add({
      'category': 'その他',
      'title': '募金',
      'description': '社会貢献をしよう',
      'image_url': 'enjoy/Donation.png',
    });
    // 完了メッセージ
    print('データの挿入が完了しました');
  }
}