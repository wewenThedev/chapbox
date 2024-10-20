//import 'package:chapbox/main.dart';

import 'package:flutter/material.dart';
import 'package:chapbox/screens/profile_screen.dart';

import 'package:chapbox/widgets/custom_appBar_with_logo.dart';
import 'package:chapbox/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {

  final String? deviceId;
  // Le constructeur prend le deviceId comme paramètre
  HomeScreen({required this.deviceId});

  // Clé pour ouvrir le Drawer avec le bouton du menu
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithLogo(
        logoPath: 'assets/logos/chapbox_Bwhite.png', // Assure-toi que le logo est dans le bon répertoire
        scaffoldKey: _scaffoldKey, // Passe la clé du Scaffold pour ouvrir le Drawer
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Page'),
            const SizedBox(height: 20),
            Text('Device ID: $deviceId'), // Affiche le deviceId ici

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen()));
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



/*
Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              'assets/logo_one.png',
              alignment: Alignment.center,
              height: 72,
            ),
          ),
        ],
      ),
    ),
  ],
)*/
