import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:chapbox/widgets/custom_button.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:chapbox/services/maps_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart' /*as flutter_map*/;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:latlong2/latlong.dart' /*as local_coordinates*/;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:custom_map_markers/custom_map_markers.dart';

//with flutter maps
class MapScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  LatLng _currentPosition = LatLng(6.5244, 3.3792); // Lagos par défaut

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
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition, 14);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carte Interactive")),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition,
          initialZoom: 14.0,
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
                child: Icon(
                    Iconsax
                        .location_copy /*Iconsax.box_copy Icons.my_location*/,
                    color: Colors.blue,
                    size: 30),
              ),
            ],
          ),
        ],
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