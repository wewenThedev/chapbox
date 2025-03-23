import 'package:chapbox/models/media.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiUrl = "http://localhost:8001/api";

class SupermarketService {
  Future<List<Supermarket>> fetchSupermarkets() async {
    final response = await http.get(Uri.parse('$apiUrl/supermarkets'));

    if (response.statusCode == 200) {
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
      }).toList();
    } else {
      throw Exception('Failed to load supermarkets');
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
        await http.get(Uri.parse('https://api.example.com/supermarkets'));

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
      Uri.parse('https://api.example.com/medias?ids=${ids.join(',')}'),
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Media.fromJson(data))
          .toList();
    }
    throw Exception('Échec du chargement des médias');
  }*/
}
