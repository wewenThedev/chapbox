import 'package:flutter/material.dart';

class MapsItineraryScreen extends StatefulWidget {
  const MapsItineraryScreen({super.key});

  @override
  State<MapsItineraryScreen> createState() => _MapsItineraryScreenState();
}

class _MapsItineraryScreenState extends State<MapsItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/*
Set<Polyline> _polylines = {};

void _drawRoute(LatLng start, LatLng end) async {
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> routeCoords = [];

  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    "YOUR_GOOGLE_MAPS_API_KEY",
    PointLatLng(start.latitude, start.longitude),
    PointLatLng(end.latitude, end.longitude),
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
}
*/
