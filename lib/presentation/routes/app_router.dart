import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/pages/home_page.dart';
import 'package:rede_confeitarias/presentation/pages/store_detail.dart';
import 'package:rede_confeitarias/presentation/pages/store_register.dart';
import 'package:rede_confeitarias/presentation/pages/stores_map.dart';
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/store-register':
        return MaterialPageRoute(builder: (_) => const StoreRegister());
      case '/store-details':
        final id = settings.hashCode;
        return MaterialPageRoute(builder: (_) => StoreDetail(idStore: id)); 
      case '/stores-map':
        return MaterialPageRoute(builder: (_) => StoresMap());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Desculpe!', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30, 
                    color: AppColors.secondary, 
                    fontWeight: FontWeight.bold),
                )
                ),
                const SizedBox(height: 20,),
                Center(child: Text(
                  'Esta página não existe. Você não tem nenhuma loja cadastrada ainda.', 
                  textAlign: TextAlign.center,
                 )),
                const SizedBox(height: 20,),

                  Builder(
                    builder: (context) => ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StoreRegister()),
                        );
                      },
                      child: Text('Cadastrar loja'),
                    ),
                  )
              ],
            ),
          ),
        );
    }
  }
}
