import 'package:flutter/material.dart';
import 'package:chapbox/configs/themes.dart'; // Import du fichier theme

import 'dart:convert';
import 'package:http/http.dart' as http;

//shopProducts details
class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final int shopId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImageUrl;

  const ProductDetailsScreen({
    super.key,
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

  /*int _currentIndex = 0;
  //à recueillir via API
  final List<String> imageUrls = [
    "https://via.placeholder.com/600x400?text=Image+1",
    "https://via.placeholder.com/600x400?text=Image+2",
    "https://via.placeholder.com/600x400?text=Image+3",
  ];*/

  int _currentIndex = 0;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchProductImages();
  }

  Future<void> fetchProductImages() async {
    final response = await http.get(Uri.parse(
        "http://127.0.0.1:8001/api/product/1/images")); //url à modifier

    if (response.statusCode == 200) {
      //List<dynamic> images = jsonDecode(response.body);
      List<String> images = jsonDecode(response.body);
      setState(() {
        //à retirer des commentaires
        //imageUrls = images.map((image) => image['url']).toList();
      });
    } else {
      print("Erreur de chargement des images");
    }
  }

//essayer d'ajouter mes boutons personnalisés

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ChapboxTheme.lightTheme.colorScheme.surface, // Couleur de fond
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: ChapboxTheme
            .lightTheme.appBarTheme.backgroundColor, // Couleur de l'AppBar
        iconTheme: IconThemeData(
            color: ChapboxTheme
                .lightTheme.colorScheme.onSurface), // Couleur des icônes
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//caroussel fin --
/*
            Column(
        children: [
          /// **Carousel d'Images**
          
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(images: imageUrls, initialIndex: _currentIndex),
                    ),
                  );
            }).toList(),
            options: CarouselOptions(
              height: 250, // Hauteur du slider
              autoPlay: true, // Défilement automatique
              enlargeCenterPage: true, // Effet de zoom sur l’image active
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        
          /// **Indicateurs de position (Dots)**
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.map((url) {
              int index = imageUrls.indexOf(url);
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.white : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
            ),*/
            /*primaryColor for dots index*/
//---fin caroussel
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
              style: ChapboxTheme.lightTheme.textTheme.headlineLarge!.copyWith(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: ChapboxTheme
                    .lightTheme.colorScheme.onSurface, // Couleur du texte
              ),
            ),
            SizedBox(height: 12.0),

            // Description du produit
            Text(
              widget.productDescription,
              style: ChapboxTheme.lightTheme.textTheme.bodyLarge!.copyWith(
                fontSize: 16.0,
                color: ChapboxTheme.lightTheme.colorScheme.onSurface,
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
                    color: ChapboxTheme
                        .lightTheme.colorScheme.primary, // Couleur du prix
                  ),
                ),
                ElevatedButton(
                  onPressed: isInStock
                      ? () {
                          // Afficher le Snackbar lorsqu'on appuie sur "Add to Cart"
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${widget.productName} a été ajouté au panier !'),
                              duration: Duration(
                                  seconds:
                                      2), // La durée d'affichage du SnackBar
                              backgroundColor: ChapboxTheme.lightTheme
                                  .colorScheme.primary, // Couleur du Snackbar
                              action: SnackBarAction(
                                label: 'Annuler',
                                textColor: ChapboxTheme.lightTheme.colorScheme
                                    .onPrimary, // Couleur du texte d'action
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: isInStock
                        ? ChapboxTheme.lightTheme.colorScheme.primary
                        : Colors.grey, // Couleur du bouton selon l'état
                  ),
                  child: Text(
                    isInStock
                        ? "Ajouter au panier"
                        : "Rupture de Stock", // Change le texte du bouton selon l'état
                    style: TextStyle(
                      fontSize: 16.0,
                      color: ChapboxTheme.lightTheme.colorScheme
                          .onPrimary, // Couleur du texte du bouton
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


/*
✅ **Explication :**  
1. **`CarouselSlider`** → Affiche les images sous forme de slider interactif.  
2. **Détection de l’image active (`onPageChanged`)** pour mettre à jour l’indicateur.  
3. **Affichage des indicateurs (dots) sous le slider** pour montrer la position actuelle.  
4. **Détails du produit sous le slider**.  
*/