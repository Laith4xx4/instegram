import 'package:flutter/material.dart';
 import 'package:instegram/screens/auth/login_screen.dart';
// import 'package:instegram/screens/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:instegram/screens/home.dart';
import 'package:instegram/screens/splash.dart';

import 'screens/main_feed_screen.dart';
//import 'package:flutter_svg/flutter_svg.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: false,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'app_title'.tr(),
      theme: ThemeData(primarySwatch: Colors.blue),
      home:Splash(),
    );
  }
}
//svg----------------->https://freesvgicons.com/
//packages------------------->https://pub.dev/
//dev------------------>https://docs.flutter.dev/ui/widgets