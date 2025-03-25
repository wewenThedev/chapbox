import 'package:chapbox/configs/const.dart';
import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart'; /*
import 'package:chapbox/models/cart.dart';*/
import 'package:chapbox/models/supermarket.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/shopProduct.dart';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class StatefulImageCard extends StatefulWidget {
  final Supermarket? supermarket;
  final int? supermarketId;
  StatefulImageCard({super.key, this.supermarket, this.supermarketId});

  @override
  State<StatefulImageCard> createState() => _StatefulImageCardState();
}

//check if to fetch all infos or just display theml deending on what is sent

class _StatefulImageCardState extends State<StatefulImageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: appLightGrey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ]),
        //La box pour garder le contenu descriptif d'un 100% Benin
        child: Column(
          children: [
            //Le contenur de l'image pour pouvoir faire la mise en forme border-radius
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 4.0),
              color:
                  onSecondaryContainerColor.withOpacity(0.5) /*appLightGrey*/,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              //child: Image.network(
              child: Image.asset(
                'images/productsImages/kitkat_nestle_paysage.jpg',
                height: 250,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Nom complet du supermarché
                  //beacoup de variables en attente
                  Text('Supermarché Erevan Calavi'),
                  SizedBox(height: 4.0),
                  //Autres détails
                  Text('Adresse : Calavi Kpota carré ...'),
                  SizedBox(height: 2.0),
                  Text('A 2,6km de votre position'),
                  SizedBox(height: 2.0),
                  //Statut d'ouverture
                  Text('Ouvert ??'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
