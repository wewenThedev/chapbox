import 'package:flutter/material.dart';

import 'package:chapbox/configs/themes.dart'; // Import du fichier theme
//import 'package:chapbox/configs/styles.dart';
// Import des styles


class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final int shopId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImageUrl;

  const ProductDetailsScreen({super.key, 
    required this.productId,
    required this.shopId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImageUrl,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isInStock = true; // Exemple d'état pour gérer si le produit est en stock

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface, // Couleur de fond
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor, // Couleur de l'AppBar
        iconTheme: IconThemeData(color: AppTheme.lightTheme.colorScheme.onSurface), // Couleur des icônes
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.productImageUrl,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.0),

            // Nom du produit
            Text(
              widget.productName,
              style: AppTheme.lightTheme.textTheme.headlineLarge!.copyWith(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightTheme.colorScheme.onSurface, // Couleur du texte
              ),
            ),
            SizedBox(height: 12.0),

            // Description du produit
            Text(
              widget.productDescription,
              style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(
                fontSize: 16.0,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24.0),

            // Prix du produit et bouton "Add to Cart"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.productPrice.toString()}",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightTheme.colorScheme.primary, // Couleur du prix
                  ),
                ),
                ElevatedButton(
                  onPressed: isInStock
                      ? () {
                          // Afficher le Snackbar lorsqu'on appuie sur "Add to Cart"
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${widget.productName} a été ajouté au panier !'),
                              duration: Duration(seconds: 2), // La durée d'affichage du SnackBar
                              backgroundColor: AppTheme.lightTheme.colorScheme.primary, // Couleur du Snackbar
                              action: SnackBarAction(
                                label: 'Annuler',
                                textColor: AppTheme.lightTheme.colorScheme.onPrimary, // Couleur du texte d'action
                                onPressed: () {
                                  // Action si l'utilisateur appuie sur "Annuler"
                                  print('Ajout annulé');
                                },
                              ),
                            ),
                          );
                        }
                      : null, // Désactive le bouton si le produit n'est pas en stock
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: isInStock
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.grey, // Couleur du bouton selon l'état
                  ),
                  child: Text(
                    isInStock ? "Add to Cart" : "Out of Stock", // Change le texte du bouton selon l'état
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppTheme.lightTheme.colorScheme.onPrimary, // Couleur du texte du bouton
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
