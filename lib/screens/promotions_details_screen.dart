import 'package:flutter/material.dart';

class PromotionsDetailsScreen extends StatefulWidget {
  const PromotionsDetailsScreen({super.key});

  @override
  State<PromotionsDetailsScreen> createState() =>
      _PromotionsDetailsScreenState();
}

class _PromotionsDetailsScreenState extends State<PromotionsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Étend le body derrière l'AppBar
      appBar: AppBar(
        title: Text("Promotion CHPX005"),
        backgroundColor: Colors.transparent,
        elevation: 0, // Supprime l'ombre de l'AppBar
      ),
      body: Center(
        child: Text('Détails de la promo'),
      ),
    );
  }
}
