import 'package:flutter/material.dart';
import 'package:rede_confeitarias/presentation/pages/home_page.dart';
import 'package:rede_confeitarias/presentation/pages/store_detail.dart';
import 'package:rede_confeitarias/presentation/pages/store_register.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/store-register':
        return MaterialPageRoute(builder: (_) => const StoreRegister());
      case '/store-details':
        final args = settings.arguments;
        return MaterialPageRoute(builder: (_) => StoreDetail()); // se precisar passar argumentos
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Esta página não existe')),
          ),
        );
    }
  }
}
