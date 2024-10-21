import 'package:flutter/material.dart';

class SupermarketDetailsScreen extends StatelessWidget {
  final int supermarketId;
  final String supermarketName;
  final String supermarketDescription;
  final String supermarketAddress;
  final String supermarketPhone;

  SupermarketDetailsScreen({required this.supermarketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supermarketName),
      ),
      body: Center(
        //child: Text('Page de présentation pour $supermarketName'),
        child: Text('Page de présentation pour Erevan'),
      ),
    );
  }
}


