import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  static const String apiUrl = "http://127.0.0.1:8001/api/locations";

  static Future<List<Marker>> fetchMarkers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> locations = jsonDecode(response.body);
      return locations.map((location) {
        return Marker(
          markerId: MarkerId(location['id'].toString()),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(title: location['name']),
        );
      }).toList();
    } else {
      //return AlertDialog.adaptive(title: Text('Erreur lors du chargement des emplacements'),)
      throw Exception("Erreur lors du chargement des emplacements");
    }
  }
}
