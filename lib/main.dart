import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//commons
import 'views/pages/commons/navigation_bar/navigation_bar.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true,),
      home:CommonNavigationBar(initialIndex: 0),
    );
  }
}