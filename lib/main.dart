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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true,),
      //home:CommonNavigationBar(initialIndex: 0),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialWithModalsPageRoute(builder: (context) => CommonNavigationBar(initialIndex: 0));
          case '/calculator':
            return MaterialWithModalsPageRoute(builder: (context) => CommonNavigationBar(initialIndex: 1));
          case '/setting':
            return MaterialWithModalsPageRoute(builder: (context) => CommonNavigationBar(initialIndex: 2));
          default:
            return MaterialWithModalsPageRoute(builder: (context) => CommonNavigationBar(initialIndex: 0));
        }
      },
    );
  }
}