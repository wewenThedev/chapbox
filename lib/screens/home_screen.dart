// ignore_for_file: library_private_types_in_public_api

import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


import 'package:chapbox/widgets/custom_appBar_title.dart';
import 'package:chapbox/widgets/drawer_menu.dart';


class HomeScreen extends StatefulWidget{

  final String? deviceId;
  // Le constructeur prend le deviceId comme paramètre
  const HomeScreen({super.key, required this.deviceId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Clé pour ouvrir le Drawer avec le bouton du menu
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

GoogleMapController? _mapController;
  LatLng _userLocation = LatLng(6.356737, 2.440927); // Position fictive de l'utilisateur
  Marker? _selectedMarker;
  bool _isPopupVisible = false;
  int? _supermarketId;
  String? _supermarketName;
  String? _supermarketAddress;
  double? _distance;


void _onDrawerChanged(bool isOpen) {
    // Fonction appelée lorsque le Drawer est ouvert ou fermé
    print('Drawer is ${isOpen ? 'open' : 'closed'}');
  }

  /*void _onDrawerEnd() {
    // Fonction appelée après la fermeture ou l'ouverture du Drawer
    print('Drawer animation has ended');
  }*/

final List<Map<String, dynamic>> categories = [
    {"icon": Icons.local_offer, "label": "Promotions"},
    {"icon": Icons.fastfood, "label": "Alimentation"},
    {"icon": Icons.liquor, "label": "Boissons"},
    {"icon": Icons.cleaning_services, "label": "Entretien"},
    {"icon": Icons.cleaning_services, "label": "Électronique"},
    {"icon": Icons.more_horiz, "label": "Autres"},
  ];

//static map
  final List<Marker> _supermarketMarkers = [
    Marker(
      markerId: MarkerId("superU1"),
      position: LatLng(6.356737, 2.440927), // Super U Akpakpa
      infoWindow: InfoWindow(title: "Super U Akpakpa"),
    ),
    Marker(
      markerId: MarkerId("superU2"),
      position: LatLng(6.365976, 2.404382), // Erevan Mont Sinai
      infoWindow: InfoWindow(title: "Erevan Mont Sinai"),
    ),
    Marker(
      markerId: MarkerId("superU3"),
      position: LatLng(6.371918, 2.386040), // Super U Fidjrossè
      infoWindow: InfoWindow(title: "Super U Fidjrossè"),
    ),
  ];

//dynamic map
/*
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _initialPosition = LatLng(6.5244, 3.3792); // Coordonnées par défaut
  Set<Marker> _markers = {};
*/
  @override
  void initState() {
    super.initState();
    /*_getUserLocation();
    _fetchSupermarkets(); //Appel API pour récupérer les supermarchés proches*/
  }
/*
  Future<void> _fetchSupermarkets() async {
    final latitude = 6.5244;  // Remplace par la position réelle de l'utilisateur
    final longitude = 3.3792; // Remplace par la position réelle de l'utilisateur

    // URL de ton API Laravel
    final String apiUrl = $BASE_URL.'api/supermarkets?latitude=$latitude&longitude=$longitude';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _updateMarkers(data); // Mise à jour des markers avec les données récupérées
      } else {
        print('Erreur de récupération des supermarchés');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void _updateMarkers(dynamic data) {
    Set<Marker> markers = {};

    for (var result in data['results']) {
      final LatLng position = LatLng(
        result['geometry']['location']['lat'],
        result['geometry']['location']['lng'],
      );

      markers.add(Marker(
        markerId: MarkerId(result['place_id']),
        position: position,
        infoWindow: InfoWindow(
          title: result['name'],
          snippet: result['vicinity'],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }

    setState(() {
      _markers = markers;
    });
  }*/

  void _getUserLocation() async {
    // Obtenir la position réelle de l'utilisateur (exemple fictif ici)
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onMarkerTapped(Marker marker, Map<String, dynamic> supermarket) {
    setState(() {
      _selectedMarker = marker;
      _supermarketName = supermarket['name'];
      _supermarketAddress = supermarket['address'];
      _distance = _calculateDistance(_userLocation, supermarket['position']);
      _isPopupVisible = true;
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters / 1000; // Convertir en kilomètres
  }

/*String supermarketName*/
  /*void _viewCatalog(int _supermarketId) { 
    //Naviguer vers la page de présentation du supermarché
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SupermarketDetailsScreen(supermarketId: _supermarketId)),
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Accueil', height: 80.0, scaffoldKey: _scaffoldKey),
      drawer: DrawerMenu(),
      onDrawerChanged: _onDrawerChanged,
      //onEndDrawerChanged: _onDrawerEnd,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Static Section Carte Google Maps
            Container(
              height: 250.0,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(6.356737, 2.440927), // Position initiale de Cotonou
                    zoom: 13.0,
                  ),
                  markers: Set<Marker>.of(_supermarketMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    // Configuration supplémentaire de la carte
                  },
                ),
              ),
            ),
              /*Dynamic Section Google Maps
            Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers, // Affiche les markers récupérés via l'API
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
            ),*/

            // Section des Catégories de Produits (défilement horizontal)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Catégories de Produits",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.0),

            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          //radius: 30.0,
                          radius: 10.0,
                          backgroundColor: const Color.fromRGBO(255, 127, 80, 0.2)   /*Colors.green[100]*/,
                          child: Icon(
                            category['icon'],
                            size: 30.0,
                            color:primaryColor /*Colors.green[700]*/,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          category['label'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                },

              ),
            ),
            /*Text(
                devi,
                style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),*/
          ],
        ),
      ),
    );
      // Pop-up affichée lors du clic sur un supermarché
          if (_isPopupVisible){
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _supermarketName ?? '',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _supermarketAddress ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Distance: ${_distance?.toStringAsFixed(2)} km',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        //_viewCatalog(_supermarketId ?? '');
                      },
                      child: Text('Voir le catalogue'),
                    ),
                  ],
                ),
              ),
            );
          }

  }
}


//a kind of splash screen
/*
Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              'assets/logo_one.png',
              alignment: Alignment.center,
              height: 72,
            ),
          ),
        ],
      ),
    ),
  ],
)*/
