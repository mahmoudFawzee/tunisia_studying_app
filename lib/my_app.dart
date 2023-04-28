import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studying_app/view/resources/routes/app_routes.dart';
import 'package:studying_app/view/screens/start/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studying_app/view/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._init();
  static const MyApp _instance = MyApp._init();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RoutesManger _routesManger = RoutesManger();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
      ],
      theme: appTheme,
      initialRoute: SplashScreen.pageRoute,
      routes: _routesManger.appRoutes(),
    );
  }

  @override
  void dispose() {
    _routesManger.dispose();
    super.dispose();
  }
}
