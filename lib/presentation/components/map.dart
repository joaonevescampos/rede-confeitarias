import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Widget buildMap(LatLng coordenadas, VoidCallback onMarkerTap) {
  return FlutterMap(
    options: MapOptions(
      initialCenter: coordenadas,
      initialZoom: 15,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        subdomains: ['a', 'b', 'c'],
      ),
      MarkerLayer(
        markers: [
          Marker(
            width: 80,
            height: 80,
            point: coordenadas,
            child: GestureDetector(
              onTap: onMarkerTap,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}