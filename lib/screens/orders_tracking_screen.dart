import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chapbox/models/order.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  List<Order> _orders = []; // Liste pour stocker les commandes

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Récupérer les commandes au démarrage
  }

  // Méthode pour récupérer les commandes depuis l'API
  Future<void> _fetchOrders() async {
    final response = await http.get(Uri.parse('https://ton-api.com/orders'));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body);
      setState(() {
        _orders = results.map((order) => Order.fromJson(order)).toList();
      });
    } else {
      // En cas d'erreur, gérer ici
      setState(() {
        _orders = [];
      });
    }
  }

  // Widget pour afficher chaque commande
  Widget _buildOrderCard(Order order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Commande #${order.id}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Statut: ${order.status}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Montant: \$${order.amount}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Date: ${order.date}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _showOrderDetails(order);
              },
              child: Text("Voir les détails"),
            ),
          ],
        ),
      ),
    );
  }

  // Affiche les détails d'une commande et mérite d'avoir une page dédiée plus tard
  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Détails de la Commande #${order.id}"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Produits:"),
                ...order.products.map((product) => Text("- ${product.name} (x${product.quantity})")),
                SizedBox(height: 8),
                Text("Montant Total: \$${order.amount}"),
                Text("Date de Commande: ${order.date}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suivi des Commandes"),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(_orders[index]);
        },
      ),
    );
  }
}
