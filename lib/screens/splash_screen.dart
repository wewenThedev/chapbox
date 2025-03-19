import 'package:chapbox/screens/on_boarding/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';



class SplashScreen extends StatefulWidget {
  final String? deviceId;
  // Le constructeur prend le deviceId comme paramètre
  const SplashScreen({super.key, required this.deviceId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();

    // Animation de scaling
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    print(widget.deviceId);

    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          //builder: (context) => HomeScreen(deviceId: widget.deviceId)));
          builder: (context) => WelcomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Nettoyage
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(  
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'logos/logo_chapbox_pin.png',
            width: 240, // Largeur de l'image
            height: 240, // Hauteur de l'image
            fit: BoxFit.contain, // Ajuste le contenu de l'image à ses dimensions
        ),
        ),
      ),
    );
  }
}
