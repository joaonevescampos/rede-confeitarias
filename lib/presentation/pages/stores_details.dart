import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/map.dart';

class StoreDetail extends StatefulWidget {
  const StoreDetail({super.key});
  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  //este dado tem que vir do backend (por meio do id, pego as coordenadas de cada loja)
  final coordenates = [LatLng(-7.04105, -34.841602)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rede de Confeitarias', 
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
              child: Text('Suas confeitarias', 
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
              child: Text('Tenta acesso a todos estabelecimentos cadastrados. Escolha no mapa a sua confeitaria para poder editá-la, excluí-la ou adicionar produtos.', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 16, 
                ),
              )
            )
          ), 
            if (coordenates.length > 0) ...[
            const SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  height: 500,
                  child: buildMap(
                    coordenates[0]!,
                    () {
                      Navigator.pushNamed(context, '/store-detail');
                    },
                  ),
                ),
              ],
            ),
          ], 
        ],
      ),
    );
  }
}