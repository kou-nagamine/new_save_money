import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topic_content_provider.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> topicContent(TopicContentRef ref, String category) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('topic_content')
      .where('category', isEqualTo: category)
      .get();

  return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}