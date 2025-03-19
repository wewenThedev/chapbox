import 'dart:async';
import 'dart:ui';
import 'package:chapbox/screens/on_boarding/steps_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

//with animation

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialisation de l'AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 1), // Durée d'un cycle (agrandissement et réduction)
    )..repeat(reverse: true); // Répéter en inversant l'animation

    // Définition de l'animation de mise à l'échelle (scale)
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    Timer(const Duration(seconds: 10), () {
      _navigateToOnBoarding();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToOnBoarding() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StepScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(
            width: media.width,
            height: media.height,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/delivery-woman-in-red-uniform-box.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(),
                    child: FadeTransition(opacity: _animation),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Positioned(
                        bottom: 64,
                        child: Text(
                          'Bienvenue dans Chapbox',
                          style: TextStyle(
                            color: Colors.white,
                            //color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.06,
                      ),
                      Positioned(
                        //bottom: 24,
                        child: Text(
                          'Nous ramenons vos supermarchés et épiceries préférées chez vous !',
                          style: TextStyle(
                            color: Colors.white60,
                            //color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          /*BackdropFilter(
                  filter: ImageFilter.blur(),
                  child: FadeTransition(opacity: _animation),
                ),          
              */
        ),
      ),
    );
  }
}
