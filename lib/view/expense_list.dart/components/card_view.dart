import 'package:flutter/material.dart';
import 'package:new_save_money/view/expense_list.dart/components/nomal_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_save_money/view_model/topic_content_provider.dart';


//NormalCardのPageView
class NomalCardView extends StatefulWidget {
  const NomalCardView({super.key, required this.category});
  final String category;

  @override
  _NomalCardViewState createState() => _NomalCardViewState();
}

class _NomalCardViewState extends State<NomalCardView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin を使う場合、この行を必ず追加
    return Consumer(
      builder: (context, ref, child) {
        final topicContentAsyncValue = ref.watch(topicContentProvider(widget.category));

        return topicContentAsyncValue.when(
          data: (documents) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.75,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final data = documents[index];
                return NomalCard(
                  index: index,
                  title: data['title'],
                  description: data['description'],
                  imageUrl: data['image_url'],
                  category: widget.category,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('エラーが発生しました: $error'),
          ),
        );
      },
    );
  }
}