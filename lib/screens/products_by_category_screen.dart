import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import model
//change page name

class ProductCategoryPage extends StatefulWidget {
  final String categoryId; // ID de la catégorie

  const ProductCategoryPage({super.key, required this.categoryId});

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  List<dynamic> products = [];
  bool isLoading = true; // Pour indiquer le chargement
  bool hasMore = true; // Pour indiquer s'il y a plus de produits à charger

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (!hasMore) return; // Si pas plus de produits à charger

    setState(() {
      isLoading = true; // Démarrer le chargement
    });

    // Remplace par l'URL de ton API
    final response = await http.get(Uri.parse('https://api.example.com/products?category_id=${widget.categoryId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        products.addAll(data['products']); // Ajouter les nouveaux produits
        hasMore = data['has_more']; // Vérifier s'il y a plus de produits
        isLoading = false; // Fin du chargement
      });
    } else {
      // Gérer l'erreur si la récupération échoue
      print("Erreur de récupération des produits");
      setState(() {
        isLoading = false; // Fin du chargement même en cas d'erreur
      });
    }
  }

  void _addToCart(String productId) {
    // Logique pour ajouter le produit au panier
    // Envoyer une requête à l'API pour ajouter le produit au panier
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catégorie de Produits"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Section des filtres
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logique de filtrage par prix
                  },
                  child: Text("Filtrer par Prix"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logique de filtrage par disponibilité
                  },
                  child: Text("Filtrer par Disponibilité"),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Liste des produits
            Expanded(
              child: ListView.builder(
                itemCount: products.length + (isLoading ? 1 : 0), // Ajouter un indicateur de chargement si en cours
                itemBuilder: (context, index) {
                  if (index == products.length) {
                    return Center(child: CircularProgressIndicator()); // Indicateur de chargement
                  }

                  var product = products[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(product['image'], width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Prix: ${product['price']}"),
                          Text("Disponibilité: ${product['available'] ? 'Disponible' : 'Indisponible'}"),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => _addToCart(product['id']),
                        child: Text("Ajouter"),
                      ),
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
