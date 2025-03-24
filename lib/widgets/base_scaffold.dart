import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/models/cart.dart';
import 'package:chapbox/models/user.dart';
import 'package:chapbox/screens/cart_screen.dart';
import 'package:chapbox/screens/home_screen.dart';
import 'package:chapbox/screens/search_screen.dart';
import 'package:chapbox/screens/settings_screen.dart';

import 'package:chapbox/screens/maps/map_screen.dart';

import 'package:chapbox/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class BaseScaffold extends StatefulWidget {
  final User? userConnected;
  final Cart? userConnectedCart;

  const BaseScaffold({super.key, this.userConnected, this.userConnectedCart});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  //late String title; // Titre pour l'AppBar
  //late Widget body; // Contenu spécifique à chaque page

  int _selectedIndex = 0;

  /*final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(
      $userCart: _userConnectedCart,
    ),
    SearchScreen(),
    SettingsScreen(),
    //MapScreen()
  ];*/

  // Déplacez la liste des pages dans le build pour avoir accès aux props
  List<Widget> get _pages => [
        HomeScreen(userConnected: widget.userConnected),
        CartScreen(
          userCart: widget.userConnectedCart,
          //user: widget.userConnected,
        ),
        SearchScreen(/*user: widget.userConnected*/),
        SettingsScreen(/*user: widget.userConnected*/),
      ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ajoute d'autres personnalisations ici si nécessaire
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        //type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: appLightGrey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        iconSize: 28,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0
                ? Iconsax.home
                : Iconsax.home /*Icons.home_filled*/),
            label: 'Accueil',
          ),
          /*BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 1 ? Iconsax.search_favorite : Iconsax.search_normal /*LineIcons.search//Icons.search*/),
          label: 'Recherche',
        ),*/
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? Iconsax.shopping_cart
                : Iconsax
                    .shopping_cart_copy /*LineIcons.shoppingCart : LineIcons.shoppingCart Icons.shopping_cart*/),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2
                ? Iconsax.shopping_bag
                : Iconsax
                    .shopping_bag_copy /*Iconsax.ship*/ /*LineIcons.search//Icons.search*/),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3
                ? Iconsax.setting
                : Iconsax
                    .setting /*LineIcons.byName('gear-1') //Icons.settings*/),
            label: 'Paramètres',
          ),
        ],
      ),
      drawer: DrawerMenu(),
      //onDrawerChanged: _onDrawerChanged,
      //onEndDrawerChanged: _onDrawerEnd,*/
    );
  }
}
