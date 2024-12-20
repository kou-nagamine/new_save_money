import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

//pages
import 'view/walkthrough/pageview.dart';
import 'view/setting/setting_page.dart';

//commons
import 'commons/navigation_bar/navigation_bar.dart';

//MaterialWithModalsPageRoute
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // ステータスバーを透明に設定
      statusBarIconBrightness: Brightness.dark, // アイコンを黒に設定
      statusBarBrightness: Brightness.light, // iOS用
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final prefs = await SharedPreferences.getInstance();
  final bool finTutorial = prefs.getBool('tutorial') ?? false;

  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey, 
          backgroundColor: Colors.white,
        ).copyWith(
          primary: Colors.white, 
          secondary: Colors.white 
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
        textTheme: GoogleFonts.notoSansJpTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
          return MaterialWithModalsPageRoute(
            builder: (_) => finTutorial 
                ? CommonNavigationBar(initialIndex: 0) 
                : PageViewWidget(),
            settings: settings,
          );
          case '/settingPage':
          return MaterialWithModalsPageRoute(
            builder: (_) => SettingPage(), // あなたの設定ページ
            settings: settings,
          );
          case '/aboutApp':
          return MaterialWithModalsPageRoute(
            builder: (_) => PageViewWidget(), // 'このアプリについて'のページ
            settings: settings,
          );
          default:
            return MaterialWithModalsPageRoute(
              builder: (_) => CommonNavigationBar(initialIndex: 0),
              settings: settings,
            );
        }
      },

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