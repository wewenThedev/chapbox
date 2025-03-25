import 'package:chapbox/models/supermarket.dart';
import 'package:chapbox/widgets/stateful_image_card.dart';
import 'package:flutter/material.dart';

import 'package:chapbox/configs/const.dart';

class SupermarketDetailsScreen extends StatelessWidget {
  final int? supermarketId;
  final Supermarket? supermarket;
  /*final String supermarketName;
  final String supermarketDescription;
  final String supermarketAddress;
  final String supermarketWebsite;*/

  const SupermarketDetailsScreen({
    super.key,
    this.supermarketId,
    this.supermarket,
    /*this.supermarketName, 
    this.supermarketDescription, 
    this.supermarketAddress,
    this.supermarketWebsite,*/
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Erevan'), //Text(supermarket.name),
        ),
        body: StatefulImageCard(
          supermarket: supermarket,
          supermarketId: supermarketId,
        ) /*Center(
        child: Text('Page de présentation pour Erevan'),
      ),*/
        );
  }
}
