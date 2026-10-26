import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';

void main() => runApp(const TurcoApp());

class TurcoApp extends StatefulWidget {
  const TurcoApp({super.key});
  @override
  State<TurcoApp> createState() => _TurcoAppState();
}

class _TurcoAppState extends State<TurcoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Turco',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
