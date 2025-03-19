import 'package:flutter/material.dart';
import 'package:chapbox/services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    // Charger d'abord les produits depuis le cache
    //getCachedProducts doit etre écrit
    List<Map<String, dynamic>> cachedProducts = await ProductService.getCachedProducts();
    setState(() => products = cachedProducts);

    // Puis rafraîchir avec les données de l'API
    await ProductService.fetchAndCacheProducts();
    List<Map<String, dynamic>> updatedProducts = await ProductService.getCachedProducts();
    setState(() => products = updatedProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Produits")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product['image'], width: 50, height: 50, fit: BoxFit.cover),
            title: Text(product['name']),
            subtitle: Text("${product['price']} €"),
          );
        },
      ),
    );
  }
}
