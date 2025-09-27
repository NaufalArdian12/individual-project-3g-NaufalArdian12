import 'package:flutter/material.dart';
import 'app/app_theme.dart';
import 'app/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter, // perhatikan nama variabel router-nya
    );
  }
}
