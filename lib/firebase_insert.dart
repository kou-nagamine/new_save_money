import 'package:cloud_firestore/cloud_firestore.dart';

class  DataInsert{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> insertData() async {
    await _firestore.collection('topic_content').add({
      'category': '勉強',
      'title': 'オンライン講座',
      'description': '勉強をしよう',
      'image_url': 'study/online.png',
    });
     await _firestore.collection('topic_content').add({
      'category': '勉強',
      'title': '書籍',
      'description': '勉強するための本を読もう',
      'image_url': 'study/frontend_book.jpg',
    });
     await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': '美容',
      'description': 'コスメ、ヘアカラー、ネイルなど',
      'image_url': 'enjoy/butiful.jpg',
    });
     await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': '外食',
      'description': 'ディナー、飲み会など',
      'image_url': 'enjoy/dinner.jpg',
    });
    await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': 'レジャー',
      'description': '旅行、アクティビティなど',
      'image_url': 'enjoy/leisure.jpg',
    });
    await _firestore.collection('topic_content').add({
      'category': '楽しむ',
      'title': 'SNS',
      'description': 'インスタ、ツイッターなど',
      'image_url': 'enjoy/sns.jpg',
    });
    await _firestore.collection('topic_content').add({
      'category': 'その他',
      'title': 'ギフト',
      'description': 'プレゼントを贈ろう',
      'image_url': 'enjoy/gift.png',
    });
    await _firestore.collection('topic_content').add({
      'category': 'その他',
      'title': '生活費',
      'description': '食費、日用品など',
      'image_url': 'enjoy/life.jpg',
    });
    // 完了メッセージ
    print('データの挿入が完了しました');
  }
}