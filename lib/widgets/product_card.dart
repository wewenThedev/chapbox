import 'package:chapbox/configs/const.dart';
import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/models/cart.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/shopProduct.dart';
import 'package:chapbox/screens/category_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class ProductCard extends StatefulWidget {
  //final Map<String, dynamic> product;
  ///final ShopProduct product; //meilleure alternative??
  final Product product;
  final Shop? shop;
  final Cart? userCart;

  const ProductCard({Key? key, required this.product, this.shop, this.userCart})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    //getDeviceId();
  }

  // 🔹 Récupérer le Device ID
  Future<void> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    setState(() {
      deviceId = androidInfo.id;
    });
  }

  // 🔹 Ajouter au panier via API
  Future<void> addToCart() async {
    if (deviceId.isEmpty) return;

    final response = await http.post(
      Uri.parse("$baseUrl/cart/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "product_id": widget.product.id,
        //"shop_id": widget.product.shop['id'],
        "device_id": deviceId
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isAddedToCart = true;
      });
    } else {
      print("Erreur lors de l'ajout au panier");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Image Produit
            Image.network(
              //widget.product['image_url'],
              '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),

            SizedBox(width: 12),

            // Détails Produit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Produit 1', //widget.product['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("5000 FCFA",
                      //Text("\$${widget.product['price']}",
                      style: TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
            ),

            // Bouton Ajouter au Panier
            IconButton(
              icon: Icon(
                isAddedToCart ? Icons.check_circle : Icons.add_circle_outline,
                color: isAddedToCart ? Colors.green : Colors.blue,
              ),
              onPressed: addToCart,
            ),
          ],
        ),
      ),
    );
  }
}
/*
class ProductCard extends StatelessWidget {
  //ShopProduct shopProduct;
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //child: Image.network(
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryListScreen() /*ProductDetailsScreen()*/),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: media.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        //borderRadius: BorderRadius.right(10.0),
                      ),
                      // Image Produit
            Image.network(
              //widget.product['image_url'],
              ''),
                      //child: Image.network(src, width: media.width * 0.3),
                      child: Image.asset(
                        'images/productsImages/kitkat_nestle_paysage.jpg',

                        //fit: BoxFit.cover,
                        fit: BoxFit.fill,
                      ),
                      /*CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(/*Icons.error */Iconsax.error),
                ),*/
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Titre',
                                  style: ChapboxTheme
                                      .lightTheme.textTheme.bodyLarge,
                                ),
                                Text(
                                  'Boutique',
                                  style: ChapboxTheme
                                      .lightTheme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Prix',
                                      style: ChapboxTheme
                                          .lightTheme.textTheme.bodySmall,
                                    ),
                                    //SizedBox()
                                    Text(
                                      'En stock',
                                      style: ChapboxTheme
                                          .lightTheme.textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    alignment: AlignmentDirectional.centerEnd,
                    iconSize: 30,
                    onPressed: () {
                      const snackBar =
                          SnackBar(content: Text('Produit ajouté au panier'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      /*setState(() {
                  isOutlined = !isOutlined; // Basculer entre Outlined et Linear
                });*/
                    },
                    icon: Icon(
                isAddedToCart ? Icons.check_circle : Iconsax
                        .add_square_copy,
                color: isAddedToCart ? primayColor : Colors.blue,
              ),
              onPressed: addToCart,
                    icon: Icon(Iconsax
                        .add_square_copy) /*Icon( Iconsax.tick_square_copy)*/ /*Icon(Iconsax.archive_add_copy)*/,
                    /* isOutlined ? Iconsax.home_outline : Iconsax.home_linear, */
                    tooltip: 'Ajouter au panier',
                    color: primaryColor,
                    disabledColor: appGrey,
                    selectedIcon: Icon(Iconsax.archive_minus),
                    isSelected: false,
                  ),
                ],
              )
            ],
          ),

          /*const snackBar = SnackBar(content: Text('Produit ajouté au panier'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
        ],
      ),
    );
  }
}

*/
