import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:latlong2/latlong.dart';

class ShopMapScreen extends StatelessWidget {
  final List<dynamic> shops;

  ShopMapScreen({required this.shops, required List supermarkets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte des supermarchés'),
        backgroundColor: Color(0xFFFF4500),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(6.3725, 2.5223), // Centrer sur une position par défaut
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: shops.map((Shop) {
              return Marker(
                point: LatLng(
                  Shop['latitude'],
                  Shop['longitude'],
                ),
                child: Icon(
                  //Icons.location_on,
                  Iconsax.location_copy /*Iconsax.box_copy Icons.my_location*/,
                  color: Color(0xFFFF4500),
                  size: 40,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
