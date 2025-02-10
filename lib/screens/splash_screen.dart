import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:chapbox/screens/home_screen.dart';


class SplashScreen extends StatefulWidget {
  final String? deviceId;
  // Le constructeur prend le deviceId comme paramètre
  const SplashScreen({super.key, required this.deviceId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(deviceId: widget.deviceId)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logos/chapbox_Borange.jpg',
          width: 150, // Largeur de l'image
          height: 150, // Hauteur de l'image
          fit: BoxFit.contain, // Ajuste le contenu de l'image à ses dimensions
        ),
      ),
      backgroundColor: primaryColor,
    );
  }
}
