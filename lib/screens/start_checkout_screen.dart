import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe principale pour la page de confirmation de commande
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Exemple d'articles du panier
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
  ];

  // Adresse de livraison par défaut (position actuelle)
  String deliveryAddress = "Votre position actuelle (géolocalisée)";

  // Méthode de paiement sélectionnée
  String selectedPaymentMethod = "Carte de crédit";

  // Fonction pour calculer le montant total
  double getTotal() {
    return cartItems.fold(0.0, (total, item) => total + (item['price'] * item['quantity']));
  }

  // Fonction pour confirmer la commande et envoyer à l'API
  Future<void> confirmOrder() async {
    final apiUrl = 'https://example.com/api/confirm_order'; // URL API Laravel

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "cartItems": cartItems,
        "deliveryAddress": deliveryAddress,
        "paymentMethod": selectedPaymentMethod,
        "totalAmount": getTotal(),
      }),
    );

    if (response.statusCode == 200) {
      print('Commande confirmée');
      // Rediriger vers une page de confirmation de commande
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
      );
    } else {
      print('Erreur lors de la confirmation de la commande');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmation de Commande"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de récapitulatif des articles
            Text(
              "Résumé des articles",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(item['imageUrl'], width: 50, height: 50),
                      title: Text(item['name']),
                      subtitle: Text("${item['quantity']} x \$${item['price']}"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            
            // Section de sélection de l'adresse de livraison
            Text(
              "Adresse de livraison",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    deliveryAddress,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_location),
                  onPressed: () {
                    // Redirection vers une page pour changer l'adresse de livraison
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeAddressPage()),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          deliveryAddress = value;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Section de sélection de la méthode de paiement
            Text(
              "Méthode de paiement",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              items: ["Carte de crédit", "Mobile Money", "Paypal"].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
            ),
            SizedBox(height: 20),
            
            // Section du montant total et du bouton de confirmation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Montant total :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${getTotal().toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Bouton "Confirmer la commande"
            Center(
              child: ElevatedButton(
                onPressed: confirmOrder,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.green,
                ),
                child: Text(
                  "Confirmer la commande",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
