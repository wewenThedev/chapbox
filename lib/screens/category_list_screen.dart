import 'dart:convert';

import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/models/category.dart';
import 'package:chapbox/screens/products_by_category_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CategoryListScreen extends StatefulWidget {
  //const to be Optional
  const CategoryListScreen({super.key});

  //List<Category> allCategories = [];

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Category>> futureCategories;
  String data = "Chargement...";

  Future<List<Category>> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse("http://localhost:8001/api/categories"));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        //final jsonList = jsonDecode(response.body);

        // Vérifiez si c'est une liste ou un objet contenant une liste

        final List<dynamic> jsonList =
            decodedData is List ? decodedData : decodedData["categories"] ?? [];

        return jsonList.map((json) => Category.fromJson(json)).toList();
        //return jsonList.map((json) => Category.fromJson(json));
      } else {
        throw Exception(
            "Echec de chargement des catégories: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Échec de la connexion: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catégories de produits')),
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
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: const Color.fromARGB(183, 255, 127, 80),
                    child: CircleAvatar(
                        radius: 15.0, child: Text('${category.id}')),
                  ),
                  title: Text(category.name ?? "Sans nom"),
                  subtitle: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    //constraints: BoxConstraints(),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                            color: appGrey,
                            width: 1.2,
                            style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          )
                        ]),

                    child: Column(
                      children: [
                        Text(category.description ?? "Pas de description"),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                          ),
                          child: Text(
                            'Xxx produits',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        //Iconsax.arrow_right_1_copy,
                        Icons.arrow_forward_ios,
                        weight: 4,
                        size: 12,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsByCategoryScreen(
                                categoryId:
                                    category.id /*'2'*/ /*'${category.id}'*/)));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
