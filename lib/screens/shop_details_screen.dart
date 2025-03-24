import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/shopProduct.dart';
import 'package:chapbox/screens/home_screen.dart';
import 'package:chapbox/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShopDetailsScreen extends StatelessWidget {
  final Shop shop;

  final List<String> shopsImages = [
    'logos/chapbox_Borange.jpg',
    'logos/chapbox_Borange.jpg',
    'logos/chapbox_Borange.jpg',
    'logos/chapbox_Borange.jpg',
  ];

  ShopDetailsScreen({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name),
        backgroundColor: primaryColorLight,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrousel d'images
            /*CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: shop.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),*/
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: shopsImages
                  .map((shopImage) => Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            shopImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),

            // Informations du supermarché
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations du supermarché',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('IFU: ${shop.supermarket!.ifu}'),
                  Text('RCCM: ${shop.supermarket!.rccm}'),
                  Text('Adresse: ${shop.supermarket!.address}'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Liste des produits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Produits disponibles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: shop.products!.length,
              itemBuilder: (context, index) {
                Product product = shop.products![index];
                return ListTile(
                  leading: Image.network(product.images!.first.url,
                      width: 50, height: 50),
                  title: Text(product.name),
                  //subtitle: Text('${product.price} FCFA'),
                  subtitle: Text(
                      '${shop.getProductPrice(product.id).toStringAsFixed(2)} FCFA'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()
                          //ProductDetailsScreen(product: product),
                          ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
