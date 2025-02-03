import 'package:flutter/material.dart';

// Page de confirmation de la commande
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commande Confirmée"),
      ),
      body: Center(
        child: Text("Merci pour votre commande!"),
      ),
    );
  }
}
