import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        primaryColor: const Color(0xFF0085FF),
        useMaterial3: true
      ),
      darkTheme: ThemeData(
        primaryColor: Color.fromARGB(255, 11, 12, 12),
        useMaterial3: true
      ),
      home:CommonNavigationBar(initialIndex: 0),
    );
  }
}