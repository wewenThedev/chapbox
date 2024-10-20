import 'package:flutter/material.dart';

class CustomAppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath; // Le chemin du logo
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Le constructeur pour accepter le logo et la clé du Scaffold pour ouvrir le Drawer
  CustomAppBarWithLogo({required this.logoPath, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Ouvre le Drawer
        },
      ),
      title: Image.asset(
        logoPath, // Le chemin de ton logo
        height: 40, // Taille du logo (ajustable selon ton besoin)
        fit: BoxFit.contain,
      ),
      centerTitle: true, // Centre le logo au milieu de l'AppBar
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Logique pour les notifications
            print('Notifications button clicked');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
