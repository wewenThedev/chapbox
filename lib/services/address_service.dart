import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'api_config.dart';

//Gomaps GéoAPIKey = AlzaSyRBoLxsbdwlOv0Y5bKhdSMmcH2T7zMk6LO

/*
  import 'package:device_info_plus/device_info_plus.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
if (kIsWeb) {
  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  print('Running on : ${webBrowserInfo.platform}');
} else {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on : ${androidInfo.product}');
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on : ${iosInfo.utsname.machine}');
  }
}
 

class GeocodeService {
  final String baseUrl;
  GeocodeService(this.baseUrl);

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    //final response = await http.get(Uri.parse($baseUrl.'geocode?address=$address'));
    final response = await http.get(Uri.parse("$baseUrl/$address"));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final location = jsonResponse['results'][0]['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

}

  class LatLng{
    String? lat;
    String? long;
    
      LatLng(location1, location2);
    

  }
*/
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chapbox/models/address.dart';

import 'package:chapbox/configs/const.dart';


class AddressService {
  static const String _baseUrl = baseUrl;
  final String? authToken;

  AddressService({this.authToken});

  // Headers communs
  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };
  }

  // CRUD Basique
  Future<List<Address>> getAllAddresses() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/addresses'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((json) => Address.fromJson(json))
          .toList();
    }
    throw _handleError(response);
  }

  Future<Address> createAddress(Address address) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/addresses'),
      headers: _headers,
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 201) {
      return Address.fromJson(jsonDecode(response.body));
    }
    throw _handleError(response);
  }

  Future<Address> getAddress(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/addresses/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    }
    throw _handleError(response);
  }

  Future<Address> updateAddress(int id, Address address) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/addresses/$id'),
      headers: _headers,
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    }
    throw _handleError(response);
  }

  Future<void> deleteAddress(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/addresses/$id'),
      headers: _headers,
    );

    if (response.statusCode != 204) {
      throw _handleError(response);
    }
  }

  // Services Géographiques
  Future<dynamic> reverseGeocode(double lat, double lng) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/addresses/reverse-geocode?lat=$lat&lng=$lng'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw _handleError(response);
  }

  //... (autres méthodes géo similaires)

  // Gestion d'erreurs
  Never _handleError(http.Response response) {
    final error = jsonDecode(response.body)?['error'] ?? 'Erreur inconnue';
    throw Exception('${response.statusCode} - $error');
  }

  /*
  import 'package:dio/dio.dart';
import 'package:your_app/models/address.dart';

class AddressService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://votre-api.com/api',
    headers: {'Accept': 'application/json'},
  ));

  // CRUD Basique
  Future<List<Address>> getAllAddresses() async {
    try {
      final response = await _dio.get('/addresses');
      return (response.data as List).map((json) => Address.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e, 'Erreur lors de la récupération des adresses');
    }
  }

  Future<Address> createAddress(Address address) async {
    try {
      final response = await _dio.post(
        '/addresses',
        data: address.toJson(),
      );
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e, 'Échec de la création de l\'adresse');
    }
  }

  Future<Address> getAddress(int id) async {
    try {
      final response = await _dio.get('/addresses/$id');
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e, 'Adresse introuvable');
    }
  }

  Future<Address> updateAddress(int id, Address address) async {
    try {
      final response = await _dio.put(
        '/addresses/$id',
        data: address.toJson(),
      );
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e, 'Échec de la mise à jour');
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      await _dio.delete('/addresses/$id');
    } on DioException catch (e) {
      throw _handleError(e, 'Échec de la suppression');
    }
  }

  // Services Géographiques
  Future<dynamic> reverseGeocode(double lat, double lng) async {
    try {
      final response = await _dio.get('/addresses/reverse-geocode', queryParameters: {
        'lat': lat,
        'lng': lng,
      });
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e, 'Géocodage inverse échoué');
    }
  }

  Future<dynamic> getNearbyPlaces({
    required double lat,
    required double lng,
    int radius = 1000,
    String type = 'restaurant',
  }) async {
    try {
      final response = await _dio.get('/addresses/nearby-places', queryParameters: {
        'lat': lat,
        'lng': lng,
        'radius': radius,
        'type': type,
      });
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e, 'Recherche de lieux proches échouée');
    }
  }

  Future<dynamic> getDirections(String origin, String destination) async {
    try {
      final response = await _dio.get('/addresses/directions', queryParameters: {
        'origin': origin,
        'destination': destination,
      });
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e, 'Calcul d\'itinéraire impossible');
    }
  }

  Future<dynamic> textSearch(String query) async {
    try {
      final response = await _dio.get('/addresses/text-search', queryParameters: {
        'query': query,
      });
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e, 'Recherche textuelle échouée');
    }
  }

  Future<dynamic> getPlaceDetails(String placeId) async {
    try {
      final response = await _dio.get('/addresses/place-details', queryParameters: {
        'place_id': placeId,
      });
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e, 'Détails du lieu indisponibles');
    }
  }

  // Gestion centralisée des erreurs
  Never _handleError(DioException e, String defaultMessage) {
    final errorMessage = e.response?.data?['message'] ?? defaultMessage;
    throw Exception('$errorMessage (Code ${e.response?.statusCode})');
  }
}
   */
}
