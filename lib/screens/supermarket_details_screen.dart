import 'package:flutter/material.dart';

import 'package:chapbox/configs/const.dart';


class SupermarketDetailsScreen extends StatelessWidget {
  final int supermarketId;
  /*final String supermarketName;
  final String supermarketDescription;
  final String supermarketAddress;
  final String supermarketWebsite;*/

  const SupermarketDetailsScreen({
    super.key,
    required this.supermarketId,
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
      body: Center(
        //child: Text('Page de présentation pour $supermarketName'),
        child: Text('Page de présentation pour Erevan'),
      ),
    );
  }
}
