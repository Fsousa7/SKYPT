import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/blank_screen.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const SkyptApp());
}

class SkyptApp extends StatefulWidget {
  const SkyptApp({super.key});
  @override
  State<SkyptApp> createState() => _SkyptAppState();
}

class _SkyptAppState extends State<SkyptApp> {
  bool _showRegister = false;
  int? _userId;

  void _onLoginSuccess(Map<String, dynamic> user) {
    setState(() {
      _userId = user['id'] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userId != null) {
      return MaterialApp(
        title: 'SKYPT Gestão 3D',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlankScreen(userId: _userId!),
        debugShowCheckedModeBanner: false,
      );
    }
    return MaterialApp(
      title: 'SKYPT Gestão 3D',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _showRegister
          ? RegisterScreen(
              onLoginTap: () => setState(() => _showRegister = false),
            )
          : LoginScreen(
              onRegisterTap: () => setState(() => _showRegister = true),
              onLoginSuccess: _onLoginSuccess,
            ),
      debugShowCheckedModeBanner: false,
    );
  }
}