import 'package:flutter/material.dart';
import 'package:rede_confeitarias/presentation/routes/app_router.dart';
import 'core/theme/app_theme.dart';

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
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/stores-map',
      debugShowCheckedModeBanner: false,
    );
  }
}
