import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:chapbox/screens/notifications_list_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double height = 100.0;
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Le constructeur pour accepter le titre et la clé du Scaffold pour ouvrir le Drawer
  const CustomAppBar(
      {super.key,
      required this.title,
      /*this.height = kToolbarHeight,*/ required this.scaffoldKey});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _toggleDrawer() {
    if (widget.scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop(); // Ferme le drawer
    } else {
      widget.scaffoldKey.currentState!.openDrawer(); // Ouvre le drawer
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          /*Icons.menu*/ Iconsax.menu,
          color: appGrey,
          size: 35.0,
        ),
        onPressed: () {
          _toggleDrawer(); // Ouvre le Drawer avec la clé du Scaffold
        },
      ),
      title: Text(
        widget.title,
        //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        style: ChapboxTheme.lightTheme.textTheme.headlineLarge,
      ),
      centerTitle: true, // Centre le titre au milieu de la barre d'applications
      actions: [
        IconButton(
          icon: Icon(
              Iconsax
                  .notification /*Iconsax.notification_bing*/ /*Icons.notifications*/,
              color: appGrey,
              size: 35.0
              /*,{size: 45.0, fill: , weight: ,}*/
              ),
          //style: ,
          onPressed: () {
            // Logique pour les notifications
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsListScreen()));
          },
        ),
      ],
    );
  }

  /* Définit la taille de la CustomAppBar
  @override
  Size get preferredSize => Size.fromHeight(height);*/
}
