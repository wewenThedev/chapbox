import 'package:flutter/material.dart';
import 'views/home_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      routes: {
        // Ajoutez vos routes ici
        // '/product_detail': (context) => ProductDetailView(),
      },
    );
  }
}
