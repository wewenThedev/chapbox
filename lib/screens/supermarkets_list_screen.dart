import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:chapbox/screens/supermarket_details_screen.dart';
import 'package:chapbox/services/supermarket_service.dart';
import 'package:chapbox/widgets/custom_appBar_with_back.dart';
import 'package:chapbox/widgets/custom_card.dart';
import 'package:chapbox/widgets/supermarket_card.dart';
import 'package:flutter/material.dart';

import 'package:chapbox/configs/const.dart';

class SupermarketListScreen extends StatefulWidget {
  const SupermarketListScreen({super.key});

  @override
  State<SupermarketListScreen> createState() => _SupermarketListScreenState();
}

class _SupermarketListScreenState extends State<SupermarketListScreen> {
  /*
  late Future<List<Category>> futureCategories;
  String data = "Chargement...";
   */

  List<Supermarket> supermarkets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSupermarkets();
  }

  Future<void> loadSupermarkets() async {
    try {
      //List<Supermarket> data = await SupermarketService.fetchSupermarkets();
      List<Supermarket> data = await SupermarketService().fetchSupermarkets();
      setState(() {
        supermarkets = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      AlertDialog(
        title: const Text("Erreur"),
        content: Text('$e'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: CustomAppBarWithBack(
          title: 'Supermarchés partenaires', scaffoldKey: _scaffoldKey),
      //pourrait partir en commentaire
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Affiche un loader pendant le chargement
          : supermarkets.isEmpty
              ? const Center(
                  child:
                      Text("Aucun supermarché trouvé")) // Si la liste est vide
              : ListView.builder(
                  itemCount: supermarkets.length,
                  itemBuilder: (context, index) {
                    final supermarket = supermarkets[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SupermarketDetailsScreen(
                                  //supermarketId: supermarket.id),
                                  supermarket: supermarket),
                            ));
                      },
                      child: SupermarketCard(supermarket: supermarket),
                    );
                  }),
    );
  }
}

/*SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
      )*/

/*
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
                    ),*/

/*
  isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: supermarkets.length,
              itemBuilder: (context, index) {
                Supermarket supermarket = supermarkets[index];
                return Column(
                  children: [
                    //mettre à jour le Gesture Detector
                    GestureDetector(

  */
