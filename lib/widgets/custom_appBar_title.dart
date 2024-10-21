import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Le constructeur pour accepter le titre et la clé du Scaffold pour ouvrir le Drawer
  CustomAppBar({required this.title, required this.scaffoldKey});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

 class _CustomAppBarState extends State<CustomAppBar>{

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
        icon: Icon(Icons.menu),
        onPressed: () {
          _toggleDrawer(); // Ouvre le Drawer avec la clé du Scaffold
        },
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true, // Centre le titre au milieu de la barre d'applications
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


  // Définit la taille de la CustomAppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
