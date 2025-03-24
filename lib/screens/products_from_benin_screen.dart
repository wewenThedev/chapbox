//import 'package:chapbox/widgets/custom_appBar_with_back.dart';
import 'dart:convert';

import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsFromBeninScreen extends StatefulWidget {
  const ProductsFromBeninScreen({super.key});

  @override
  State<ProductsFromBeninScreen> createState() =>
      _ProductsFromBeninScreenState();
}

class _ProductsFromBeninScreenState extends State<ProductsFromBeninScreen> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void fetchProducts() async {
    List<dynamic> products = await ProductService.getProducts();
    print(products);
  }

  List products = [];

  @override
  void initState() {
    super.initState();
    fetchLocalProducts();
  }

  Future<void> fetchLocalProducts() async {
    final response = await http.get(Uri.parse(
        "http://127.0.0.1/api/shopsAndProducts/findBenineseProducts"));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception("Échec du chargement des produits");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produits Locaux"),
        backgroundColor: primaryColorLight,
        elevation: 2.0,
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[
                    index]; ////mise à jour to show shopProduct with stock and price
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text(product['description']),
                  leading: product['media'].isNotEmpty
                      ? Image.network(product['media'][0]['url'],
                          width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image_not_supported),
                  trailing: Text("Shop: ${product['shop']['name']}"),
                );
              },
            ),
    );
  }
}
