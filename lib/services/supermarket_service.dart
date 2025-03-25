import 'package:chapbox/configs/const.dart';
import 'package:chapbox/models/media.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//const String apiUrl = "http://127.0.0.1:8001/api";
const String apiUrl = baseUrl;

class SupermarketService {
  /*static*/ Future<List<Supermarket>> fetchSupermarkets() async {
    //avec static j'appelle ça avec SupermarketService.fetchSupermarkets()
    //static Future<List<Supermarket>> fetchSupermarkets() async { ////avec static j'appelle ça avec SupermarketService().fetchSupermarkets()
    final response = await http.get(Uri.parse('$apiUrl/supermarkets'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      print(jsonData);

      final List<dynamic> jsonList =
          jsonData is List ? jsonData : jsonData["supermarkets"] ?? [];

      print(jsonList);

      //return jsonList.map((json) => Category.fromJson(json)).toList();
      return jsonList.map((data) => Supermarket.fromJson(data)).toList();

/*
      List<dynamic> data = json.decode(response.body);
      return data.map((supermarket) {
        return Supermarket(
          id: supermarket['id'],
          name: supermarket['name'],
          addressId: supermarket['address_id'],
          shops: (supermarket['shops'] as List).map((shop) {
            return Shop(
              id: shop['id'],
              //name: shop['name'],
              city: shop['city'],
              address: shop['address'],
              phone: shop['phone'],
              addressId: shop['address_id'],
              supermarketId: shop['supermarket_id'],
            );
          }).toList(),
        );
      }).toList();*/
    } else {
      throw Exception('Echec lors du chargement des supermarchés');
    }
  }

//fetch supermarket aginate

/*
  static Future<List<Supermarket>> getSupermarketsWithLogos() async {
    try {
      // 1. Récupération des supermarchés
      final supermarkets = await _fetchSupermarkets();

      // 2. Extraction des IDs de logos
      final logoIds = supermarkets
          .where((s) => s.logoId != null)
          .map((s) => s.logoId!)
          .toSet()
          .toList();

      // 3. Récupération des médias correspondants
      final medias = await _fetchMedias(logoIds);

      // 4. Mapping des logos aux supermarchés
      final mediaMap = {for (var m in medias) m.id!: m};

      return supermarkets.map((s) {
        return s.copyWith(
          logo: mediaMap[s.logoId],
        );
      }).toList();
    } catch (e) {
      throw Exception('Erreur de chargement: ${e.toString()}');
    }
  }

  static Future<List<Supermarket>> _fetchSupermarkets() async {
    final response =
        await http.get(Uri.parse('$apiUrl/supermarkets'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Supermarket.fromJson(data))
          .toList();
    }
    throw Exception('Échec du chargement des supermarchés');
  }

  static Future<List<Media>> _fetchMedias(List<int> ids) async {
    if (ids.isEmpty) return [];

    final response = await http.get(
      Uri.parse('apiUrl/medias?ids=${ids.join(',')}'),
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Media.fromJson(data))
          .toList();
    }
    throw Exception('Échec du chargement des médias');
  }*/
}
