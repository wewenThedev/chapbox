/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:flutter_map/flutter_map.dart' /*as flutter_map*/;

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
*/

import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<List<dynamic>> fetchNearbySupermarkets(
      double latitude, double longitude) async {
    const String apiUrl = 'http:localhost:8001/api';
    final response = await http.get(
      Uri.parse('$apiUrl/nearby-supermarkets?lat=$latitude&lng=$longitude'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['supermarkets'];
    } else {
      throw Exception('Failed to load nearby supermarkets');
    }
  }
}
