import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart'; // exemplo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Redes de Confeitarias',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
