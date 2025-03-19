//import 'package:chapbox/widgets/custom_appBar_with_back.dart';
import 'package:chapbox/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsFromBeninScreen extends StatefulWidget {
  const ProductsFromBeninScreen({super.key});

  

  @override
  State<ProductsFromBeninScreen> createState() => _ProductsFromBeninScreenState();
}

class _ProductsFromBeninScreenState extends State<ProductsFromBeninScreen> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void fetchProducts() async {
  List<dynamic> products = await ProductService.getProducts();
  print(products);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBarWithBack(title: 'Produits Made In Benin', scaffoldKey: _scaffoldKey),
      appBar: AppBar(
        title: Text('Produits Made In Benin'),
        centerTitle: true, 
        automaticallyImplyLeading: true,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Text('Liste des produits fabriqués au Bénin'),
        ), 
      ),
    );
  }
}