import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:latlong2/latlong.dart';

class ShopMapScreen extends StatelessWidget {
  final List<dynamic> shops;

  const ShopMapScreen(
      {super.key, required this.shops, required List supermarkets});

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
/*

if (response.statusCode == 200) {
      List<dynamic> locations = jsonDecode(response.body);
      return locations.map((location) {
        return Marker(
            //markerId: MarkerId(location['id'].toString()),
            point: LatLng(location['lat'], location['lng']),
            //infoWindow: InfoWindow(title: location['name']),
            //child: showDialog(elevation: 2.0, child: Text(location['name'])),
            child: IconButton(
                onPressed: () {
                  var distance = Geolocator.distanceBetween(
                      _currentPosition.latitude,
                      _currentPosition.longitude,
                      location['lat'],
                      location['lng']);
                  Dialog(
                    backgroundColor: Colors.white54,
                    child: Column(
                      children: [
                        Row(
                          children: [Text(location['name'])],
                        ),
                        Column(children: [
                          Text('Boutique située à $distance'),
                        ]),
                      ],
                    ),
                  );
                  /*
                                      // Afficher une boîte de dialogue avec les détails du supermarché
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(supermarket.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Adresse: ${supermarket.address}'),
                              SizedBox(height: 8),
                              Text('Distance: ${supermarket.distance.toStringAsFixed(2)} km'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fermer la boîte de dialogue
                              },
                              child: Text('Fermer'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fermer la boîte de dialogue
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SupermarketDetailsPage(supermarket: supermarket),
                                  ),
                                );
                              },
                              child: Text('Voir détails'),
                            ),
                          ],
                        );
                      },

                  */
                },
                icon: Icon(Iconsax.shopping_cart,
                    color: primaryColorLight, size: 40)));
      }).toList();
    }*/
