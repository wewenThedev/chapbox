import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chapbox/configs/themes.dart'

class ChangeAddressPage extends StatefulWidget {
  @override
  _ChangeAddressPageState createState() => _ChangeAddressPageState();
}

class _ChangeAddressPageState extends State<ChangeAddressPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestedAddresses = []; // Pour stocker les adresses proposées
  String _selectedAddress = "Aucune adresse sélectionnée"; // Adresse sélectionnée
  LatLng _markerLocation = LatLng(0, 0); // Position initiale pour la carte

  // Simuler une recherche d'adresses depuis l'API
  Future<void> _searchAddress(String query) async {
    if (query.isNotEmpty) {
      // Appel à l'API pour obtenir les adresses suggérées
      final response = await http.get(Uri.parse($BASE_URL.'addresses?query=$query'));

      if (response.statusCode == 200) {
        // Si l'API renvoie un succès, analyser les données
        final List<dynamic> results = json.decode(response.body);
        setState(() {
          _suggestedAddresses = results.map((address) => address['formatted_address']).toList(); // Supposant que l'API retourne des adresses au format souhaité
        });
      } else {
        // En cas d'erreur
        setState(() {
          _suggestedAddresses = []; // Réinitialiser la liste en cas d'erreur
        });
      }
    } else {
      setState(() {
        _suggestedAddresses = [];
      });
    }
  }

  // Mettre à jour l'adresse sélectionnée et la position du marqueur
  void _selectAddress(String address) {
    setState(() {
      _selectedAddress = address;
      // Mise à jour de la position du marqueur (ici tu devrais obtenir les coordonnées de l'API ou d'un autre service)
      _markerLocation = LatLng(12.3456, 78.9101); // Coordonnées fictives
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Changer l'adresse de livraison"),
      ),
      body: Column(
        children: [
          // Section de recherche d'adresse
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher une adresse",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchAddress(_searchController.text);
                  },
                ),
              ),
              onSubmitted: _searchAddress,
            ),
          ),

          // Liste déroulante des adresses suggérées
          Expanded(
            child: ListView.builder(
              itemCount: _suggestedAddresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestedAddresses[index]),
                  onTap: () {
                    _selectAddress(_suggestedAddresses[index]);
                    // Effacer les suggestions après sélection
                    _suggestedAddresses.clear();
                  },
                );
              },
            ),
          ),

          // Carte affichant la position de l'adresse sélectionnée
          Container(
            height: 300, // Hauteur de la carte
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _markerLocation,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selectedAddress'),
                  position: _markerLocation,
                  infoWindow: InfoWindow(title: _selectedAddress),
                ),
              },
            ),
          ),

          // Affichage de l'adresse sélectionnée
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Adresse sélectionnée : $_selectedAddress",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
