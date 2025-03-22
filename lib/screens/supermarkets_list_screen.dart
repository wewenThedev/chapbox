import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:chapbox/screens/supermarket_details_screen.dart';
import 'package:chapbox/widgets/custom_appBar_with_back.dart';
import 'package:chapbox/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class SupermarketListScreen extends StatefulWidget {
  const SupermarketListScreen({super.key});

  @override
  State<SupermarketListScreen> createState() => _SupermarketListScreenState();
}

class _SupermarketListScreenState extends State<SupermarketListScreen> {
  final List<Supermarket> supermarkets = [];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: CustomAppBarWithBack(
          title: 'Supermarchés partenaires', scaffoldKey: _scaffoldKey),
      body: Column(
        children: [
          GestureDetector(
            child: LogoCard(
                title: 'Erevan',
                subtitle: 'Supermarchés meilleur du Bénin',
                logo: 'logos/logo_chapbox_pin.png'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SupermarketDetailsScreen(
                          supermarketId: 10,
                        )),
              );
            },
          ),
          GestureDetector(
            child: LogoCard(
                title: 'Erevan',
                subtitle: 'Supermarchés meilleur du Bénin',
                logo: 'logos/logo_chapbox_pin.png'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SupermarketDetailsScreen(
                          supermarketId: 10,
                        )),
              );
            },
          ),
        ],
      ),
/*ListView.builder(
        itemCount: supermarkets.length,
        itemBuilder: (context, index) {
          Supermarket supermarket = supermarkets[index];
        ),        return*/
    );
  }

  /*List<Supermarket> generateFakeData() {
  return [
    Supermarket(
      id: 1,
      name: 'Supermarket A',
      shops: [
        Shop(id: 1, /*name: 'Shop A1',*/ city: 'Cotonou', addressId: '123 Rue du Commerce'),
        Shop(id: 2, /*name: 'Shop A2',*/ city: 'Porto-Novo', addressId: '456 Avenue des Marchés'),
      ],
    ),
    Supermarket(
      id: '2',
      name: 'Supermarket B',
      shops: [
        Shop(id: '3', name: 'Shop B1', city: 'Parakou', address: '789 Boulevard des Affaires'),
        Shop(id: '4', name: 'Shop B2', city: 'Abomey-Calavi', address: '101 Rue des Artisans'),
      ],
    ),
  ];
}*/
}
