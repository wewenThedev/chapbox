import 'dart:convert';

import 'package:chapbox/models/category.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {

late Future<List<Category>> futureCategories;
    String data = "Chargement...";

  Future<List<Category>> fetchData() async {
  try {
    final response = await http.get(Uri.parse("http://localhost:8001/api/categories"));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      //final jsonList = jsonDecode(response.body);

      // Vérifiez si c'est une liste ou un objet contenant une liste
      
          final List<dynamic> jsonList = decodedData is List 
          ? decodedData 
          : decodedData["categories"] ?? [];

      return jsonList.map((json) => Category.fromJson(json)).toList();
      //return jsonList.map((json) => Category.fromJson(json));
    } else {
      throw Exception("Failed to load categories: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Échec de la connexion: $e");
  }
}


  @override
  void initState() {
    super.initState();
    futureCategories = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text('Catégories de produits')),
      body: FutureBuilder<List<Category>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune catégorie trouvée"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return ListTile(
                  title: Text(category.name ?? "Sans nom"),
                  subtitle: Text(category.description ?? "Pas de description"),
                );
              },
            );
          }
        },
      ),
    );
  }
}