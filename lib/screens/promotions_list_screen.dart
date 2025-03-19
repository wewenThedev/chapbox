import 'package:flutter/material.dart';

class PromotionsListScreen extends StatefulWidget {
  const PromotionsListScreen({super.key});

  @override
  State<PromotionsListScreen> createState() => _PromotionsListScreenState();
}

class _PromotionsListScreenState extends State<PromotionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Promotions')),
      body: Center(
        child: Text('Liste des promotions'),
      ),
    );
  }
}