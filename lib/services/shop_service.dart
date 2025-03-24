import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chapbox/database_helper.dart';

import 'package:chapbox/configs/const.dart';

class ShopService {
  static const String apiUrl = "$baseUrl/shops";

  /// Récupérer les boutiques depuis l'API et les stocker en cache
  static Future<void> fetchAndCacheShops() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> shops = jsonDecode(response.body);

      final db = await DatabaseHelper.database;
      await db.transaction((txn) async {
        await txn.delete('shops'); // Nettoyer avant d'insérer
        for (var shop in shops) {
          await txn.insert('shops', {
            'id': shop['id'],
            'name': shop['name'],
            'location': shop['location'] ?? '',
          });
        }
      });

      // Sauvegarde aussi dans SharedPreferences (cache rapide)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cached_shops', jsonEncode(shops));
    }

    final List jsonDecoded = jsonDecode(response.body);
    //return response;
  }

  /// Charger les boutiques depuis le cache local
  static Future<List<Map<String, dynamic>>> getCachedShops() async {
    final db = await DatabaseHelper.database;
    return await db.query('shops');
  }

  /// Charger les boutiques depuis SharedPreferences (cache rapide)
  static Future<List<dynamic>> getShopsFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cached_shops');

    return jsonDecode(cachedData!);
    //return [];
  }
}
