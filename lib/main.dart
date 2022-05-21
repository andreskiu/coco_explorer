import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/presentation/core/styles/light_theme.dart';

import 'package:flutter_base/presentation/core/responsivity/responsive_calculations.dart';
import 'config/injectable/injectable.dart';
import 'presentation/explorer/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    initConfig(),
  ]);
  runApp(
    EasyLocalization(
      // For translation to work on iOS you need to add supported locales
      // to ios/Runner/Info.plist. Look for easy_localization documentation
      supportedLocales: [Locale('en'), Locale('es')],
      path: 'assets/i18n',
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getThemeData(ColorPaletteLight()),
      themeMode: ThemeMode.light, //Dark Mode disabled
      builder: (context, router) {
        Info(mediaQueryData: MediaQuery.of(context));
        return router!;
      },
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
      },
    );
  }
}
