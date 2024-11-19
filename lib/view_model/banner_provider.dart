import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_provider.g.dart';

@riverpod
Future<List<Map<String, String>>> banner(BannerRef ref) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('banner').get();

  final List<Map<String, String>> bannerData = await Future.wait(
    snapshot.docs.map((doc) async {
      final data = doc.data() as Map<String, dynamic>;

      // Firebase Storage から完全なダウンロード URL を取得
      final String imgUrl = await FirebaseStorage.instance.ref(data['img_url']).getDownloadURL();

      return {
        'img_url': imgUrl,
        'content_url': data['content_url'] as String,
      };
    }).toList(),
  );

  return bannerData;
}