import 'dart:convert';

import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart' /*as flutter_map*/;
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:latlong2/latlong.dart' /*as local_coordinates*/;
//import 'package:custom_map_markers/custom_map_markers.dart';

//with flutter maps
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  LatLng _currentPosition = LatLng(6.5244, 3.3792); // Lagos par défaut

  final List<LatLng> markerPositions = [
    LatLng(48.8566, 2.3522), // Paris
    LatLng(45.7640, 4.8357), // Lyon
    LatLng(43.2965, 5.3698), // Marseille
  ];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  ///Récupérer la Position Actuelle de l'Utilisateur
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(
        //locationSettings: LocationSettings.accuracy,
        //accuracy : LocationAccuracy.high
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition, 14);
    });
  }

  static Future<List<Marker>> fetchMarkers(_currentPosition) async {
    const String apiUrl = "http://127.0.0.1:8001/api/locations";

    final response = await http.get(Uri.parse(apiUrl));

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
                },
                icon: Icon(Iconsax.shopping_cart,
                    color: primaryColorLight, size: 40)));
      }).toList();
    } else {
      //return AlertDialog.adaptive(title: Text('Erreur lors du chargement des emplacements'),)
      throw Exception("Erreur lors du chargement des emplacements");
    }
  }
  //pour les fonction avec exception on fait try{} catch . Exemple :
  /*
          child: ElevatedButton(
            onPressed: () async {
              try {
                // Appel d'une fonction qui peut throw une exception
                await fetchData();
              } catch (e) {
                // Afficher l'erreur dans un SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text('Charger les données'),
          ),
        ),
      ),
    );
  }
*/

  void _loadMarkers() async {
    List<Marker> markers = await fetchMarkers(_currentPosition);
    setState(() => _markers.addAll(markers));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carte Interactive")),
      body: GestureDetector(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentPosition,
            //zoom à modifier
            //chercher comment détecter uniquement les marqueurs spécifiques ajoutés sur l'écran
            initialZoom: 20.0, //14.0,
            onTap: (position, latLng) {
              print("Clic à ${latLng.latitude}, ${latLng.longitude}");
              // Ajouter un marqueur dynamiquement...
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentPosition,
                  width: 40,
                  height: 40,
                  child: Icon(Iconsax.box,
                      /*Iconsax
                        .location_copy Icons.my_location,*/
                      color: primaryColorLight,
                      size: 40),
                ),
                Marker(
                  point: LatLng(6.3552, 2.4194),
                  width: 40,
                  height: 40,
                  child: IconButton(
                      onPressed: () {
                        var distance = Geolocator.distanceBetween(
                            _currentPosition.latitude,
                            _currentPosition.longitude,
                            6.3552,
                            2.4194);
                        Dialog(
                          backgroundColor: Colors.white54,
                          child: Column(
                            children: [
                              Row(
                                children: [Text('Position 2')],
                              ),
                              Column(children: [
                                Text(
                                    'Boutique située à $distance de Position 1'),
                              ]),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Iconsax.box,
                          /*Iconsax
                        .location_copy Icons.my_location,*/
                          color: primaryColorLight,
                          size: 40)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//with googleMaps
/*
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(6.5244, 3.3792); // Lagos par défaut

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// Obtenir la position actuelle de l'utilisateur
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    });
  }

  void _loadMarkers() async {
    List<Marker> markers = await MapService.fetchMarkers();
    setState(() => _markers.addAll(markers));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Carte Interactif")),
        //remplacer GoogleMap par FlutterMap
        body: Center(
          child: Column(
            children: [
//for FlutterMap who can use another API

              flutter_map.FlutterMap(
                mapController: MapController(),
                options: flutter_map.MapOptions(),
                children: [
                  Stack(
                    children: [
                      Text('Welcome on this map'),
                      Text('Go Owen to Master it'),
                    ],
                  ),
                  //ElevatedButton(onPressed: onPressed, child: child)

                  LargeTextButton(
                      content: 'Go to Details',
                      action: () {},
                      type: ButtonType.elevated),
                ],
              ),

//for Google Maps
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _currentPosition, zoom: 14),
                onMapCreated: (controller) => _mapController = controller,
                myLocationEnabled:
                    true, // Affiche le point de localisation actuel
                myLocationButtonEnabled: true,
              ),
            ],
          ),
        ));
  }
}*/


//Polyline

  /*Set<Polyline> _polylines = {};

  void _drawRoute(LatLng start, LatLng end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> routeCoords = [];

  flutter_map.PolylineLayer(polylines: polylines)

  flutter_map.Polyline(points: routeCoords, borderColor: primaryColorLight, color: primaryColor);

  //flutter_map.MultiFingerGesture();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "YOUR_GOOGLE_MAPS_API_KEY",
      request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(end.latitude, end.longitude),
          mode: TravelMode.driving /*TravelMode.walking*/),
    );

    if (result.status == "OK") {
      for (var point in result.points) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId("route"),
        points: routeCoords,
        color: primaryColor,
        width: 5,
      ));
    });
  }*/