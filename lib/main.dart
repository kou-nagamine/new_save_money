import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/views/pages/topic/components/topic_content.dart';

//commons
import 'views/pages/commons/navigation_bar/navigation_bar.dart';

//MaterialWithModalsPageRoute
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(),
        useMaterial3: true
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.dark(),
      //   useMaterial3: true
      // ),
      //home:TopicContent(),
      home:CommonNavigationBar(initialIndex: 0),
    );
  }
}