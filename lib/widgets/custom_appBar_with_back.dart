import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/screens/home_screen.dart';
import 'package:chapbox/screens/notifications_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomAppBarWithBack extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final double height = 100.0;
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Le constructeur pour accepter le titre et la clé du Scaffold pour ouvrir le Drawer
  const CustomAppBarWithBack(
      {super.key,
      required this.title,
      /*this.height = kToolbarHeight,*/ required this.scaffoldKey});

  @override
  _CustomAppBarWithBackState createState() => _CustomAppBarWithBackState();
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarWithBackState extends State<CustomAppBarWithBack> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(/*Iconsax.arrow_left*/ Iconsax.arrow_square_left_copy,
            color: appGrey, size: 35.0),
        onPressed: () {
          // back
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          //Navigator.pop(context);
          //Navigator.maybePop(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          //Navigator.pop(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          //Navigator.canPop(context);
        },
      ),
      title: Text(
        widget.title,
        //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationsListScreen()) );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsListScreen()));
          },
        ),
      ],
    );
  }

  /* Définit la taille de la CustomAppBarWithBack
  @override
  Size get preferredSize => Size.fromHeight(height);*/
}
