import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//databaseに追加
import 'firebase_insert.dart';

import '/views/pages/topic/components/topic_content.dart';

import '../views/pages/walkthrough/pageview.dart';

//commons
import 'views/pages/commons/navigation_bar/navigation_bar.dart';

//MaterialWithModalsPageRoute
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  final prefs = await SharedPreferences.getInstance();
  final bool finTutorial = prefs.getBool('tutorial') ?? false;

  // データ挿入処理
  //await DataInsert().insertData();
  runApp(
    ProviderScope(
      child: MyApp(finTutorial:finTutorial),
    )
  );
}

class MyApp extends StatelessWidget{
  final bool finTutorial;
  const MyApp({super.key, required this.finTutorial});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(),
        useMaterial3: true,
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.dark(),
      //   useMaterial3: true
      // ),
      //home:PageViewWidget(),
       home: finTutorial
          ? CommonNavigationBar(initialIndex: 0)
          : PageViewWidget(),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 英語
        const Locale('ja', 'JP'), // 日本語
      ],
    );
  }
}