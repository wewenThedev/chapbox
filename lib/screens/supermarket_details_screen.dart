import 'package:flutter/material.dart';

class SupermarketScreen extends StatelessWidget {
  final String supermarketName;
  final String supermarketDescription;
  final String supermarketAddress;
  final String supermarketPhone;

  SupermarketScreen({required this.supermarketName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supermarketName),
      ),
      body: Center(
        child: Text('Page de présentation pour $supermarketName'),
      ),
    );
  }
}


