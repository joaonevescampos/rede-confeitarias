import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/map_all_stores.dart';
import 'package:rede_confeitarias/presentation/pages/store_detail.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';

class StoresMap extends StatefulWidget {
  const StoresMap({super.key});

  @override
  State<StoresMap> createState() => _StoresMapState();
}

class _StoresMapState extends State<StoresMap> {
  @override
  void initState() {
    super.initState();
    fetchStores();
  }
  final StoreRepository _storeRepository = StoreRepository();
  List<Store> stores = [];

  Future<void> fetchStores() async {
    try {
      final List<Store> allStores = await _storeRepository.getAllStores();
      setState(() {
        stores = allStores;
      });
    } catch (error) {
      print('Erro ao buscar lojas: $error');
    }  
  }

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
      drawer: CustomDrawer(),
      body: 
      ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text('Confira sua loja no mapa. Clique na marcação para ver detalhes da sua loja.', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary, 
                  fontSize: 16, 
                ),
              )
            )
          ), 
          Container(
            height: 650,
            padding: EdgeInsets.all(16),
            child: buildMap(stores, (LatLng coordenadas) {
              Store? selectedStore = stores.firstWhere(
                  (store) => store.latitude == coordenadas.latitude && store.longitude == coordenadas.longitude,
                  orElse: () => stores[0]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetail(idStore: selectedStore.id),
                ),
              );
            }),
          ),
        ],
      )
      
    );
  }
}