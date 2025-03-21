import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/screens/maps/map_screen.dart';
import 'package:chapbox/screens/shop_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:chapbox/services/maps_service.dart';

class NearbySupermarketsPage extends StatefulWidget {
  const NearbySupermarketsPage({super.key});

  @override
  _NearbySupermarketsPageState createState() => _NearbySupermarketsPageState();
}

class _NearbySupermarketsPageState extends State<NearbySupermarketsPage> {
  List<dynamic> supermarkets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNearbySupermarkets();
  }

  Future<void> loadNearbySupermarkets() async {
    try {
      Position position = await MapService.getCurrentLocation();
      List<dynamic> results = await MapService.fetchNearbySupermarkets(
        position.latitude,
        position.longitude,
      );
      setState(() {
        supermarkets = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supermarchés à proximité'),
        backgroundColor: primaryColorLight,
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopMapScreen(
                    supermarkets: supermarkets,
                    shops: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: supermarkets.length,
              itemBuilder: (context, index) {
                var supermarket = supermarkets[index];
                return ListTile(
                  title: Text(supermarket['name']),
                  subtitle: Text(supermarket['distance']),
                  onTap: () {
                    // Naviguer vers la page du supermarché
                  },
                );
              },
            ),
    );
  }
}

/*78632 code extraction aomei partition zip */

/*import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';

class ShopListPage extends StatelessWidget {
  final List<Map<String, dynamic>> shops = [
    {
      "name": "Super U Akpakpa",
      "address": "Cotonou, Akpakpa",
      "distance": 1.2, // distance en kilomètres
    },
    {
      "name": "Erevan Mont Sinai",
      "address": "Cotonou, Mont Sinai",
      "distance": 2.5,
    },
    {
      "name": "Super U Fidjrossè",
      "address": "Cotonou, Fidjrossè",
      "distance": 3.8,
    },
  ];

  ShopListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de la page
            Text(
              "Succursales proches de vous",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),

            // Liste des succursales
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        shop['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        shop['address'],
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${shop['distance']} km",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Action à faire lorsque l'utilisateur clique sur une succursale
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
