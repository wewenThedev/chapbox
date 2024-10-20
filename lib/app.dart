import 'package:chapbox/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        // Ajoutez vos routes ici
        // '/product_detail': (context) => ProductDetailView(),
      },
    );
  }
}
