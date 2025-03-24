// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:chapbox/configs/const.dart';
import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/models/category.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/user.dart';
import 'package:chapbox/screens/address_list_screen.dart';
import 'package:chapbox/screens/auth/login_screen.dart';
import 'package:chapbox/screens/category_list_screen.dart';
import 'package:chapbox/screens/products_by_category_screen.dart';
import 'package:chapbox/screens/products_from_benin_screen.dart';
import 'package:chapbox/screens/profile_screen.dart';
import 'package:chapbox/screens/promotions_list_screen.dart';
import 'package:chapbox/screens/search_screen.dart';
import 'package:chapbox/screens/supermarket_details_screen.dart';
import 'package:chapbox/screens/supermarkets_list_screen.dart';
import 'package:chapbox/widgets/custom_appBar_with_logo.dart';
import 'package:chapbox/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  //final String? deviceId;

  final User? userConnected;
  // Le constructeur prend le deviceId comme paramètre
  const HomeScreen(
      {super.key,
      /*required this.deviceId*/
      this.userConnected});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Clé pour ouvrir le Drawer avec le bouton du menu
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Category> firstSixCategories = [];
  List<Product> localProducts = [];
  bool isLoading = true;

//getUserCurrentPosition

  GoogleMapController? _mapController;
  LatLng _userLocation =
      LatLng(6.356737, 2.440927); // Position fictive de l'utilisateur
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

  List<Map<String, dynamic>> productsMadeInBenin = [];

  fetchTopCategories() async {
    //api/categories/top-categories
    String $baseUrl = baseUrl;
    /*final response = await http
        .get(Uri.parse("http://127.0.0.1:8001/api/categories/top-categories"));*/
    final response =
        await http.get(Uri.parse("$baseUrl/categories/top-categories"));

    if (response.statusCode == 200) {
      setState(() {
        firstSixCategories = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception("Erreur lors du chargement des catégories");
    }
  }

  //fetchproductsMadeInBenin() {} //api/products/local-products
  Future<void> fetchLocalProducts() async {
    final response = await http.get(Uri.parse(
        "$baseUrl/shopsAndProducts/findBenineseProducts"));
        //"http://127.0.0.1:8001/api/shopsAndProducts/findBenineseProducts"));

    if (response.statusCode == 200) {
      setState(() {
        localProducts = json.decode(response.body);
      });
    } else {
      throw Exception("Échec du chargement des produits locaux");
    }
  }

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
    fetchTopCategories();

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
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

  final List<String> supermarketLogos = [
    'assets/logo1.png',
    'assets/logo2.png',
    'assets/logo3.png',
    'assets/logo4.png',
  ];

// Liste de démonstration avec des ID virtuels et URLs de logos
  final List<Map<String, dynamic>> supermarketsLogoId = [
    {
      'id': 101,
      'logoUrl': 'https://example.com/logo_carrefour.png',
    },
    {
      'id': 102,
      'logoUrl': 'https://example.com/logo_auchan.png',
    },
    {
      'id': 103,
      'logoUrl': 'https://example.com/logo_leclerc.png',
    },
    {
      'id': 104,
      'logoUrl': 'https://example.com/logo_intermarche.png',
    },
    {
      'id': 105,
      'logoUrl': 'https://example.com/logo_casino.png',
    },
  ];

  /*List<Map<String, dynamic>>*/ getProductsMadeInBenin() {
    return;
  }

/*String supermarketName*/
  void _viewCatalog(int _supermarketId) {
    //Naviguer vers la page de présentation du supermarché
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SupermarketDetailsScreen(supermarketId: _supermarketId)),
    );
  }

  void _onSupermarketTap(int index) {
    //Logique pour affiche pager de présentation du supermarché
    // Gérer le clic sur un logo
    print('Logo cliqué:'); //${supermarketLogos[index]}');
  }

  Widget _buildLogoItem(String imageUrl, int supermarketId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SupermarketDetailsScreen(supermarketId: supermarketId)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/logos/chapbox_Borange.jpg'),
            //AssetImage(imageUrl),
            /*NetworkImage(
              imageUrl),*/ // Ou AssetImage pour les ressources locales
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _showAllSupermarkets() {
    // Navigation vers l'écran complet
    print('Afficher tous les supermarchés');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      /*appBar: CustomAppBar(
          title: 'Accueil', /*height: 80.0,*/ scaffoldKey: _scaffoldKey),*/
      appBar: CustomLogoAppBar(scaffoldKey: _scaffoldKey),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom: 8),
              decoration:
                  BoxDecoration(color: /*secondaryColor*/ primaryColorLight),
              accountName: Text("John Doe",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              accountEmail: Text("johndoe@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/user_avatar.png'), /*Image.network('images/user_avatar.png') ,*/ /*NetworkImage(
                    "https://i.pravatar.cc/300"), // Remplace par l'URL de ton image*/
              ),
            ),
            ListTile(
              leading: const Icon(
                Iconsax.ticket_discount_copy /*Icons.local_offer*/,
                size: 35,
                color: appLightGrey,
              ),
              title: const Text('Promotions'),
              style: ListTileStyle.drawer,
              titleTextStyle: TextStyle(
                  color: appGrey, fontSize: 18, fontWeight: FontWeight.w600),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PromotionsListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Iconsax.location_copy /*Icons.history*/,
                size: 35,
                color: appLightGrey,
              ),
              title: const Text('Adresses'),
              style: ListTileStyle.drawer,
              titleTextStyle: TextStyle(
                  color: appGrey, fontSize: 18, fontWeight: FontWeight.w600),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressListScreen()));
              },
            ),
            /*ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historique des commandes'),
            onTap: () {

Navigator.pop(context); // Ferme le Drawer
            },),*/
            ListTile(
              leading: const Icon(
                Iconsax.personalcard_copy,
                /*Iconsax.profile_circle_copy*/ /*Iconsax.profile_2user_copy*/ /*Icons.person*/
                size: 35,
                color: appLightGrey,
              ),
              title: const Text('Profil',
                  style: TextStyle(
                      color: appGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              style: ListTileStyle.drawer,
              //titleTextStyle: TextStyle(color: appGrey, fontSize: 18, fontWeight: FontWeight.w600),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            Divider(
              height: 50,
            ), // Séparateur visuel
            ListTile(
              leading: const Icon(
                Iconsax.logout_1_copy /*Icons.exit_to_app*/,
                size: 35,
                color: appLightGrey,
              ),
              title: const Text('Déconnexion'),
              style: ListTileStyle.drawer,
              //titleTextStyle: ChapboxTheme.lightTheme.textTheme.bodyLarge,
              titleTextStyle: TextStyle(
                  color: appGrey, fontSize: 18, fontWeight: FontWeight.w600),
              onTap: () {
//Navigator.pop(context); // Ferme le Drawer
//logique de déconexion - close session
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: /*SearchBar(
                elevation: WidgetStatePropertyAll(0.0),
                hintText: "Que cherchez-vous ?",
                hintStyle: ChapboxTheme.lightTheme.searchBarTheme.hintStyle,
                leading: IconButton(
                    icon: Icon(/*LineIcons
                        .search*/
                        Iconsax.search_normal_copy /*Icons.search*/),
                    onPressed: () {}),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
              ),*/
                  TextField(
                decoration: InputDecoration(
                  fillColor: appLightGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon:
                      Icon(/*LineIcons
                        .search*/
                          Iconsax.search_normal_copy /*Icons.search*/),
                  filled: true,
                  hintText: "Que cherchez-vous ?",
                  hintStyle: TextStyle(color: appGrey),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
            ),

            //Static Section Carte Google Maps
            Container(
              height: 250.0,
              width: double.infinity,
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
              child: Center(
                child: Text('Votre carte'),
              ),
              /*ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        6.356737, 2.440927), // Position initiale de Cotonou
                    zoom: 13.0,
                  ),
                  markers: Set<Marker>.of(_supermarketMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    // Configuration supplémentaire de la carte
                  },
                ),
              ),*/
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
                "Catégories",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.0),
//we are here to list just four or five first categories
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: firstSixCategories.length,
                itemBuilder: (context, index) {
                  final topCategory = firstSixCategories[index];
                  do {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      /*height: ,
                    width: ,
                    constraints: BoxConstraints(),*/
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsByCategoryScreen(
                                              categoryId: topCategory.id)));
                            },
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: const Color.fromRGBO(
                                  255, 127, 80, 0.2) /*Colors.green[100]*/,
                              child: Icon(
                                categories.elementAt(index)['icon'],
                                size: 30.0,
                                color: primaryColor /*Colors.green[700]*/,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            topCategory.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    );
                  } while (index < firstSixCategories.length);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    /*height: ,
                    width: ,
                    constraints: BoxConstraints(),*/
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryListScreen()));
                          },
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor:
                                const Color.fromRGBO(255, 127, 80, 0.2),
                            child: Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Autres',
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
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '100% Bénin',
                        style: ChapboxTheme.lightTheme.textTheme.headlineSmall,
                      ),
                      /*),
                          SizedBox(
                            width: media.width * 0.5,
                          ),
                          SizedBox(
                              width: media.width * 0.2,
                              child: */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsFromBeninScreen()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Découvrir',
                                    //style: ChapboxTheme.lightTheme.textTheme.bodyLarge,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: primaryColorLight,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios,
                                      /*Iconsax
                                  .arrow_right_4,
                              Iconsax.arrow_2_copy*/
                                      color: primaryColor)
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                      child: /*Column*/ Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1
                          //Margin
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 3.0),

                            //Le conteneur de tout un produit 100% Benin
                            //boucle pour afficher tous les produits madeInBenin
                            child: Container(
                              width: /*125,*/ media.width * 0.425,

                              margin: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: appLightGrey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              //La box pour garder le contenu descriptif d'un 100% Benin
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Permet au Container de s'ajuster au contenu
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Le contenur de l'image pour pouvoir faire la mise en forme border-radius
                                  Container(
                                    margin: EdgeInsetsDirectional.symmetric(
                                        horizontal: 6.0, vertical: 3.0),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      //side: BorderSide
                                    ),
                                    //child: Image.network(
                                    child: Image.asset(
                                      'images/productsImages/kitkat_nestle_paysage.jpg',
                                      //child: Image.file('images/productsImages/kitkat nestlé paysage.jpg',
                                      // Ajuste la largeur mais pas la hauteur
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Permet au Container de s'ajuster au contenu

                                      children: [
                                        Text('Titre du produit'),
                                        SizedBox(height: 4.0),
                                        //Autres détails
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text('Supermarché vendeur')
                                              ],
                                            ),
                                            /*Column(
                                            children: [
                                              Text('Prix'),
                                              SizedBox(height: 2.0),
                                              Text('En stock'),
                                            ],
                                          )*/
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //2
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 3.0),

                            //Le conteneur de tout un produit 100% Benin
                            //boucle pour afficher tous les produits madeInBenin
                            child: Container(
                              width: media.width * 0.425,
                              margin: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: appLightGrey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              //La box pour garder le contenu descriptif d'un 100% Benin
                              child: Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Permet au Container de s'ajuster au contenu
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Le contenur de l'image pour pouvoir faire la mise en forme border-radius
                                  Container(
                                    /*margin:
                                      EdgeInsetsDirectional.only(bottom: 4.0),*/
                                    margin: EdgeInsetsDirectional.symmetric(
                                        horizontal: 6.0, vertical: 3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    //child: Image.network(
                                    child: Image.asset(
                                      'images/productsImages/kitkat_nestle_paysage.jpg',
                                      //child: Image.file('images/productsImages/kitkat nestlé paysage.jpg',
                                      //width: double.infinity, // Ajuste la largeur mais pas la hauteur
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Permet au Container de s'ajuster au contenu

                                      children: [
                                        Text('Titre du produit'),
                                        SizedBox(height: 4.0),
                                        //Autres détails
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text('Supermarché vendeur')
                                              ],
                                            ),
                                            /*Column(
                                            children: [
                                              Text('Prix'),
                                              SizedBox(height: 2.0),
                                              Text('En stock'),
                                            ],
                                          )*/
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                        ],
                      )),

                  //custom card code
                  Container(
                    width: double.infinity,
                    margin: EdgeInsetsDirectional.symmetric(
                        horizontal: 6.0, vertical: 3.0),
                    child: Column(
                      children: [
                        //to made dynamic
                        ProductCard(),
                        ProductCard(),
                      ],
                    ),
                  ),

                  /*Text()
                Image.network('src')*/

                  /*Text(
                            'Redécouvrez vos marques préférées',
                            //style: style,
                          ),*/
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
                  child: Text(
                    'Nos supermarchés partenaires',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 12, // Espace horizontal entre les logos
                    runSpacing: 12, // Espace vertical entre les lignes
                    alignment: WrapAlignment.center,
                    children: [
                      /*...supermarketLogos
                        .take(3)
                        .map((url) => _buildLogoItem(url)),
*/

                      for (int indexLogo = 0; indexLogo < 3; indexLogo++)
                        _buildLogoItem(supermarketLogos[indexLogo],
                            10 /*supermarketLogos[supermarketId]*/),

//icone +
// Quatrième élément conditionnel
                      if (supermarketLogos.length > 3)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SupermarketListScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.grey[600],
                            ),
                          ),
                        )

/*Container(
      width: 80,
      height: 80,
      child: Icon(Iconsax.add_square),
    ),*/
                    ],
                  ),
                ),
              ],
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
    if (_isPopupVisible) {
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
