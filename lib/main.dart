import 'package:chapbox/screens/auth/register_screen.dart';
import 'package:chapbox/screens/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io'; // Pour identifier le type de plateforme (iOS ou Android)
import 'package:chapbox/screens/home_screen.dart'; // Assure-toi que la page HomePage est créée
import 'package:chapbox/screens/splash_screen.dart';
import 'package:chapbox/configs/themes.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'notification_helper.dart';

/*sdkmanager --install "platform-tools" "platforms;android-34" "system-images;android-34;google_apis;x86_64" "emulator"

ACtiver la détection pour windows flutter */

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
    NotificationHelper.initNotifications();
    checkLastVisit();
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
      } else if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        deviceId = webInfo.browserName.toString();
      } else {
        deviceId = 'Appareil inconnu';
      }

      setState(() {
        _deviceId = deviceId;
      });
    } catch (e) {
      setState(() {
        _deviceId = 'La récupération du device_id a échoué';
      });
    }
  }

  void checkLastVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastVisit = prefs.getString('last_visit');

    DateTime lastDate = DateTime.parse(lastVisit!);
    //if (DateTime.now().difference(lastDate).inDays >= 7) {
    if (DateTime.now().difference(lastDate).inMinutes >= 5) {
      //if (DateTime.now().difference(lastDate).inHours >= 1) {
      await NotificationHelper.showNotification(
        title: "Vous nous manquez !",
        body: "Revenez voir les nouvelles offres et promotions !",
      );
    }

    await prefs.setString('last_visit', DateTime.now().toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    /*final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;*/

    return MaterialApp(
      title: 'Chapbox',
      theme: ChapboxTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // Définir la page de démarrage (HomePage) ou une autre page
      home: SplashScreen(
          //HomeScreen() /*RegisterScreen()*/
          deviceId: _deviceId), // On passe le deviceId à la page d'accueil
      // Définir les routes de l'application
      routes: {
        '/home': (context) => HomeScreen(/*deviceId: _deviceId*/),
        '/search': (context) => SearchScreen()
      },
    );
  }
}

//$ npm i lineicons
