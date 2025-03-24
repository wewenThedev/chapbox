/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'package:chapbox/configs/const.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}*/



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'package:chapbox/configs/const.dart';

class ApiService {
  //static const String apiUrl = "http://127.0.0.1:8001/api";
  static const String apiUrl = baseUrl;

  static Future<Map<String, String>> getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> get(String endpoint) async {
    return await http.get(Uri.parse('$apiUrl/$endpoint'), headers: await getHeaders());
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    return await http.post(Uri.parse('$apiUrl/$endpoint'), body: jsonEncode(data), headers: await getHeaders());
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    return await http.put(Uri.parse('$apiUrl/$endpoint'), body: jsonEncode(data), headers: await getHeaders());
  }

  static Future<http.Response> delete(String endpoint) async {
    return await http.delete(Uri.parse('$apiUrl/$endpoint'), headers: await getHeaders());
  }
}