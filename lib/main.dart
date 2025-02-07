import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io'; // Pour identifier le type de plateforme (iOS ou Android)
import 'package:chapbox/screens/home_screen.dart'; // Assure-toi que la page HomePage est créée
import 'package:chapbox/screens/splash_screen.dart'; 
import 'package:chapbox/configs/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _deviceId = '';

  @override
  void initState() {
    super.initState();
    _getDeviceId();
  }

  // Fonction pour récupérer le Device ID
  Future<void> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // Unique ID pour Android
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor; // Unique ID pour iOS
      } else {
        deviceId = 'Unknown Device';
      }

      setState(() {
        _deviceId = deviceId;
      });
    } catch (e) {
      setState(() {
        _deviceId = 'Failed to get Device ID';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapbox',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // Définir la page de démarrage (HomePage) ou une autre page
      home: SplashScreen(deviceId: _deviceId), // On passe le deviceId à la page d'accueil
      // Définir les routes de l'application
      routes: {
        '/home': (context) => HomeScreen(deviceId: _deviceId)
      },
    );
  }
}
