import 'dart:convert';
import 'package:chapbox/models/shopProduct.dart';
import 'package:chapbox/services/api_service.dart';
import 'package:chapbox/configs/const.dart';
import 'package:http/http.dart' as http;

class ShopProductService {
  static Future<List<dynamic>> getShops() async {
    final response = await ApiService.get("shops");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getProduct(int id) async {
    final response = await ApiService.get("products/$id");
    return jsonDecode(response.body);
  }

  /// Récupère la liste des produits locaux (Béninois)
  Future<List<ShopProduct>> fetchLocalProducts() async {
    final response = await http
        .get(Uri.parse("$baseUrl/shopsAndProducts/findBenineseProducts"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Si la réponse est directement une liste, sinon adaptez la clé d'extraction (ex: "products")
      final List<dynamic> jsonList =
          jsonData is List ? jsonData : jsonData["products"] ?? [];
      return jsonList.map((data) => ShopProduct.fromJson(data)).toList();
    } else {
      throw Exception(
          "Échec du chargement des produits locaux (status: ${response.statusCode})");
    }
  }

  //avec base de données locale

/*
  import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String apiUrl = "$baseUrl/products";

  /// Récupérer les produits depuis l'API et les stocker en cache
  static Future<void> fetchAndCacheProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> products = jsonDecode(response.body);

      final db = await DatabaseHelper.database;
      await db.transaction((txn) async {
        for (var product in products) {
      // Vérifier si la version en cache est obsolète
      List<Map<String, dynamic>> existingProduct = await db.query(
        'products',
        where: "id = ?",
        whereArgs: [product['id']],
      );

      if (existingProduct.isEmpty || existingProduct[0]['updated_at'] != product['updated_at']) {
        await db.insert(
          'products',
          {
            'id': product['id'],
            'name': product['name'],
            'price': product['price'],
            'image': product['image'],
            'updated_at': product['updated_at'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
      });
    }
  }

  /// Récupérer les produits depuis le cache local
  static Future<List<Map<String, dynamic>>> getCachedProducts() async {
    final db = await DatabaseHelper.database;
    return await db.query('products');
  }
}
*/
}
