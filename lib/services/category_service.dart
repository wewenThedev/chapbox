import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chapbox/models/category.dart';



//Endpoint : GET /shops/{shopId}/categories

Future<List<Category>> fetchCategoriesByShop(int shopId) async {
  final response = await http.get(
    Uri.parse($BASE_URL.'$shopId/categories'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((category) => Category.fromJson(category)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}


