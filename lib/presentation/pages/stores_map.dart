import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/add_button.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/pages/product_register.dart';

// Função para construir o mapa com base nas coordenadas passadas
Widget buildMap(List<Store> stores, Function(LatLng) onMarkerTap) {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(stores[0].latitude, stores[0].longitude), // Centraliza no primeiro item
      initialZoom: 15,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        subdomains: ['a', 'b', 'c'],
      ),
      MarkerLayer(
        markers: stores.map((store) {
          return Marker(
            width: 80,
            height: 80,
            point: LatLng(store.latitude, store.longitude),
            child: GestureDetector(
              onTap: () {
                onMarkerTap(LatLng(store.latitude, store.longitude));
              },
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

class StoresMap extends StatelessWidget {
  final List<Store> stores = [
    Store(
      id: 1,
      name: 'Doces & Delícias',
      latitude: -23.5505,
      longitude: -46.6333,
    ),
    Store(
      id: 2,
      name: 'Sabor de Açúcar',
      latitude: -23.5515,
      longitude: -46.6343,
    ),
    Store(
      id: 3,
      name: 'Delícias da Vovó',
      latitude: -23.5525,
      longitude: -46.6353,
    ),
  ];

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
        // mainAxisAlignment: MainAxisAlignment.center,
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
              // Ao clicar no marcador, navega para a página de detalhes da loja
              Store? selectedStore = stores.firstWhere(
                  (store) => store.latitude == coordenadas.latitude && store.longitude == coordenadas.longitude,
                  orElse: () => stores[0]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetailPage(store: selectedStore),
                ),
              );
            }),
          ),
        ],
      )
      
    );
  }
}

class Store {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  Store({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class StoreDetailPage extends StatelessWidget {
  final Store store;

  StoreDetailPage({required this.store});

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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 280,
                child: Center(
                  child: Text('Nome da loja', 
                    style: TextStyle(
                      color: AppColors.secondary, 
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  )
                )
              ),
              IconButton(onPressed: (){
                Navigator.pushNamed(context, '/update-store');
              }, 
              icon: Icon(Icons.settings, 
              color: AppColors.secondary, 
              size: 20,))
            ],
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
                MaterialPageRoute(builder: (_) => ProductRegister(idStore: 1)),
              );
            },
          ),
    );
  }
}
