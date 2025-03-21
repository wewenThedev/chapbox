
import 'dart:convert';
import 'package:chapbox/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:chapbox/services/api_service.dart';

import 'package:sqflite/sqflite.dart';

class ProductService {
  static const String apiUrl = "http://127.0.0.1:8001/api";

  static Future<List<dynamic>> getProducts() async {
    final response = await ApiService.get("products");
    return jsonDecode(response.body);
  }


  /*static Future<Map<String, dynamic>> getProducts(int page) async {
    final response = await http.get(Uri.parse('$apiUrl/products?page=$page'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur lors du chargement des produits");
    }
  }*/


  static Future<Map<String, dynamic>> getProduct(int id) async {
    final response = await ApiService.get("products/$id");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createProduct(Map<String, dynamic> productData) async {
    final response = await ApiService.post("products", productData);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateProduct(int id, Map<String, dynamic> productData) async {
    final response = await ApiService.put("products/$id", productData);
    return jsonDecode(response.body);
  }

  static Future<void> deleteProduct(int id) async {
    await ApiService.delete("products/$id");
  }

  static Future<void> fetchAndCacheProducts() async {

  //final response = await http.get(Uri.parse(apiUrl));
  final response = await http.get(Uri.parse("http://127.0.0.1:8001/api/products"));

  if (response.statusCode == 200) {
    List<dynamic> products = jsonDecode(response.body);

    final db = await DatabaseHelper.database;
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
  }
}

  static getCachedProducts() {}

}
