import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'blank_screen.dart';
import 'language_selector.dart';
import 'theme_notifier.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const SkyptApp(),
    ),
  );
}

class SkyptApp extends StatefulWidget {
  const SkyptApp({super.key});
  @override
  State<SkyptApp> createState() => _SkyptAppState();
}

class _SkyptAppState extends State<SkyptApp> {
  bool _showRegister = false;
  int? _userId;
  Locale? _selectedLocale;

  void _onLoginSuccess(Map<String, dynamic> user) {
    setState(() {
      _userId = user['id'] as int;
    });
  }

  void _onLocaleSelected(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'SKYPT Gestão 3D',
          theme: themeNotifier.lightTheme,
          darkTheme: themeNotifier.darkTheme,
          themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          locale: _selectedLocale ?? const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: _userId == null
              ? (_showRegister
                  ? RegisterScreen(
                      onLoginTap: () => setState(() => _showRegister = false),
                    )
                  : LoginScreen(
                      onRegisterTap: () => setState(() => _showRegister = true),
                      onLoginSuccess: _onLoginSuccess,
                    ))
              : (_selectedLocale == null
                  ? LanguageSelectorPage(
                      onSelectLocale: _onLocaleSelected,
                    )
                  : BlankScreen(userId: _userId!)),
        );
      },
    );
  }
}