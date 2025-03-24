import 'package:chapbox/screens/start_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chapbox/configs/const.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Exemple de données des articles du panier
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Pomme Rouge",
      "imageUrl": "https://via.placeholder.com/150",
      "price": 2.50,
      "quantity": 2,
    },
    {
      "id": 2,
      "name": "Bouteille d'eau 1L",
      "imageUrl": "https://via.placeholder.com/150",
      "price": 0.80,
      "quantity": 6,
    },
    {
      "id": 3,
      "name": "Baguette de Pain",
      "imageUrl": "https://via.placeholder.com/150",
      "price": 1.20,
      "quantity": 3,
    },
  ];

  //String apiUrl = "https://example.com/api"; // URL de base de ton API Laravel

  double getTotal() {
    return cartItems.fold(0.0, (total, item) => total + (item['price'] * item['quantity']));
  }

  // Fonction pour envoyer la modification de la quantité au serveur
  Future<void> updateQuantity(int index, int newQuantity) async {
    final item = cartItems[index];
    final url = Uri.parse('$baseUrl/cart/${item['id']}');
    
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'quantity': newQuantity,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        cartItems[index]['quantity'] = newQuantity;
      });
    } else {
      print('Erreur lors de la mise à jour de la quantité');
    }
  }

  // Fonction pour supprimer un produit du panier côté serveur
  Future<void> removeItemFromCart(int index) async {
    final item = cartItems[index];
    final url = Uri.parse('$baseUrl/cart/${item['id']}');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        cartItems.removeAt(index);
      });
    } else {
      print('Erreur lors de la suppression de l\'article');
    }
  }

  // Gestion de l'augmentation de la quantité
  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
    updateQuantity(index, cartItems[index]['quantity']);
  }

  // Gestion de la diminution de la quantité
  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      setState(() {
        cartItems[index]['quantity']--;
      });
      updateQuantity(index, cartItems[index]['quantity']);
    }
  }

  // Fonction pour retirer l'article du panier
  void removeItem(int index) {
    removeItemFromCart(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Panier"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image du produit
                          Image.network(
                            item['imageUrl'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          // Informations du produit
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "\$${item['price'].toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Bouton pour diminuer la quantité
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      onPressed: () => decreaseQuantity(index),
                                    ),
                                    Text(
                                      '${item['quantity']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    // Bouton pour augmenter la quantité
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      onPressed: () => increaseQuantity(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Bouton pour supprimer l'article
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Section pour afficher le total et le bouton de commande
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  // Affichage du total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total :",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${getTotal().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Bouton "Passer à la commande"
                  ElevatedButton(
                    onPressed: () {
                      // Action à réaliser lors de la commande
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Passer à la commande",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
