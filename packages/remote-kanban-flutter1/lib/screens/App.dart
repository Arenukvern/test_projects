import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:test_fl_kanban/constants/Locales.dart';
import 'package:test_fl_kanban/localizations/MainLocalizations.dart';
import 'package:test_fl_kanban/models/TasksModel.dart';
import 'package:test_fl_kanban/screens/AuthScreen.dart';
import 'package:test_fl_kanban/screens/TasksScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: kIsWeb ? (() async => '')() : findSystemLocale(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String _locale = snapshot.data == '' ? Languages.en : snapshot.data;
          Intl.defaultLocale = _locale;

          MainLocalizationsDelegate _localeOverrideDelegate =
              MainLocalizationsDelegate(Locale(Intl.defaultLocale));
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => TasksModel()),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localeListResolutionCallback: (locales, supportedLocales) {
                    Locale locale = _localeOverrideDelegate.overridenLocale;
                    bool isFoundLocale =
                        _localeOverrideDelegate.isSupported(locale);
                    if (!isFoundLocale) {
                      return Locales.en;
                    }
                    return locale;
                  },
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    _localeOverrideDelegate,
                  ],
                  supportedLocales: [
                    Locales.en,
                    Locales.ru,
                  ],
                  title: 'Kanban',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      brightness: Brightness.dark,
                      backgroundColor: Colors.black),
                  initialRoute: '/',
                  routes: {
                    '/': (context) => AuthScreen(),
                    '/tasks': (context) => TasksScreen(),
                  }));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
