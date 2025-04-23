import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/map.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';

class StoreDetail extends StatefulWidget {
  const StoreDetail({super.key});
  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  //este dado tem que vir do backend (por meio do id, pego as coordenadas de cada loja)
  final coordenates = [LatLng(-7.04105, -34.841602)];
  String name = 'Confeitaria do João';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redes de confeitarias', 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold,
          ),
          ),
      ),
      drawer: Drawer(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            child: Center(
              child: Text('$name', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ),
          SizedBox(height: 20,),
          Container(
            child: Center(
              child: Text('Tenta acesso a todos produtos cadastrados desta loja. Aperte no botão + para criar novo produto.', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 16, 
                ),
              )
            )
          ), 
        ],
      ),
      floatingActionButton: AddButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductRegister()),
              );
            },
          ),
    );
  }
}