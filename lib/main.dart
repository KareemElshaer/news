import 'package:flutter/material.dart';
import 'package:news/providers/language_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/ui/home_screen/home.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_theme.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProv = Provider.of<LanguageProvider>(context);
    var themeProv = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: {AppRoutes.homeScreen: (context) => HomeScreen()},
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProv.themeMode,
      locale: Locale(languageProv.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
