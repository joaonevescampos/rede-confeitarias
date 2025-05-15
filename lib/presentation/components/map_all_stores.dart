import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/models/store_model.dart';

// Função para construir o mapa com base nas coordenadas passadas
Widget buildMap(List<Store> stores, Function(LatLng) onMarkerTap) {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(-15.7801, -47.9292), // Centraliza no primeiro item em Brasília
      initialZoom: 4,
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