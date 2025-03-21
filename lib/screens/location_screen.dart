import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationStatus =
      'Vérification du droit d\'accès à la position géographique...';

  @override
  void initState() {
    super.initState();
    checkLocationPermissions();
  }

  Future<void> checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationStatus = 'Services de géolocalisation désactivés';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationStatus =
              'Autorisation d\'accès à la position géographique refusée.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationStatus =
            'Autorisation d\'accès à la position géographique refusée permanament.';
      });
      return;
    }

    setState(() {
      locationStatus =
          'Autorisation d\'accès à la position géographique acceptée.';
    });

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      locationStatus = 'Location: ${position.latitude}, ${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Permissions'),
        backgroundColor: Color(0xFFFF4500),
      ),
      body: Center(
        child: Text(locationStatus),
      ),
    );
  }
}
