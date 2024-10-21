import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chapbox/widgets/base_scaffold.dart';
import 'package:chapbox/screens/product_details_screen.dart';
import 'package:chapbox/screens/profile_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  Future<void> _search(String query) async {
    setState(() {
      _isLoading = true; // Démarrer le chargement
      _searchResults.clear(); // Effacer les résultats précédents
    });

    // Remplace par l'URL de ton API de recherche
    final response = await http.get(Uri.parse('https://127.0.0.1:8000/api/search?query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _searchResults = data['results']; // Récupérer les résultats de recherche
        _isLoading = false; // Fin du chargement
      });
    } else {
      // Gérer l'erreur si la récupération échoue
      print("Erreur de récupération des résultats de recherche");
      setState(() {
        _isLoading = false; // Fin du chargement même en cas d'erreur
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barre de recherche
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Rechercher des produits ou des supermarchés",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _search(_searchController.text); // Démarrer la recherche
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            // Affichage des résultats
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        var item = _searchResults[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Image.network(item['image'], width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(item['name']),
                            subtitle: Text("Prix: ${item['price']}"),
                            onTap: () {
                              // Naviguer vers la page de détails du produit ou du supermarché
                              // par exemple: Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(productId: item['id'])));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: item['id'], shopId : 1/*To change later*/)));
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
