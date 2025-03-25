import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chapbox/models/category.dart';
import 'package:chapbox/configs/const.dart';
import 'package:chapbox/services/api_service.dart';

class CategoryService {
  Future<List<Category>> fetchTopCategories() async {
    final response =
        await http.get(Uri.parse("$baseUrl/categories/top-categories"));

    if (response.statusCode == 200) {
      // On décode la réponse JSON
      final dynamic jsonData = jsonDecode(response.body);

      // Si la réponse est directement une liste, on l'utilise, sinon on cherche une clé particulière
      final List<dynamic> jsonList = jsonData is List
          ? jsonData
          : jsonData["categories"] ?? jsonData["data"] ?? [];

      // Transformation en liste de Category
      return jsonList.map((data) => Category.fromJson(data)).toList();
    } else {
      throw Exception(
          "Erreur ${response.statusCode} lors du chargement des catégories");
    }
  }

  Future<List<dynamic>> getCategories() async {
    final response = await ApiService.get("categories");
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getCategory(int id) async {
    final response = await ApiService.get("categories/$id");
    return jsonDecode(response.body);
  }

//endpoint GET All categories
//Ce qui importe, c'est la vague sur laquelle vous surfez

  Future<List<Category>> fetchAllCategories() async {
    final response = await http.get(
      //Uri.parse('http://127.0.0.1:8001/api/categories'),
      Uri.parse('$baseUrl/categories'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load all categories');
    }
  }

//Endpoint : GET /shops/{shopId}/categories

  Future<List<Category>> fetchCategoriesByShop(int shopId) async {
    final response = await http.get(
      //Uri.parse('http://127.0.0.1:8001/api/$shopId/categories'),
      Uri.parse('$baseUrl/$shopId/categories'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories by shop');
    }
  }
}

/* 

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chapbox_new/utils/configs.dart';

import 'package:chapbox_new/models/category.dart';

//Endpoint : GET /categories
//Future<List<Category>> fetchAllCategories() async
Future fetchAllCategories() async {
  
  //final client = http.Client();

  final url = '$baseUrl/categories';
  final uri = Uri.parse(url);
  final response = await http.get(uri);

  final List<Category> result = jsonDecode(response.body);
  if(response.statusCode == 200){
    return result;
  }else{
    final Map errorData = {
      "statusCode" : response.statusCode,
      "errorMessage" : "Something went wrong",
    };
    return errorData;
  }
}

//Endpoint : GET /shops/{shopId}/categories

Future<List<Category>> fetchCategoriesByShop(int shopId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/$shopId/categories'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((category) => Category.fromJson(category)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

*/
