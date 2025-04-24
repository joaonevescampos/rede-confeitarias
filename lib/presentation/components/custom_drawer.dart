import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.quarternary,
      child: ListView(
        padding: EdgeInsets.zero, // Remove o padding padrão
        children: <Widget>[
          // Cabeçalho do Drawer
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.quarternary,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Itens do menu (links de navegação)
          ListTile(
            leading: Icon(Icons.home, color: Colors.white,),
            title: Text('Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/'); // Define a rota de navegação
            },
          ),
          ListTile(
            leading: Icon(Icons.add, color: Colors.white,),
            title: Text('Cadastrar loja', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/store-register');
            },
          ),
          ListTile(
            leading: Icon(Icons.store, color: Colors.white,),
            title: Text('Minhas lojas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/stores-details');
            },
          ),
        ],
      ),
    );
  }
}
