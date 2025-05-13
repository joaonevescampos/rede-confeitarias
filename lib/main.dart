import 'package:flutter/material.dart';
import 'package:rede_confeitarias/db/db_helper.dart';
import 'package:rede_confeitarias/presentation/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();

  await dbHelper.resetDatabase();
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
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
