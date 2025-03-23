import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/screens/cart_screen.dart';
import 'package:chapbox/screens/home_screen.dart';
import 'package:chapbox/screens/search_screen.dart';
import 'package:chapbox/screens/settings_screen.dart';

import 'package:chapbox/screens/maps/map_screen.dart';

import 'package:chapbox/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  //late String title; // Titre pour l'AppBar
  //late Widget body; // Contenu spécifique à chaque page

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    SearchScreen(),
    SettingsScreen(),
    //MapScreen()
  ];

/*final List<String> _titles = [
    "Accueil",
    "Recherche",
    "Panier",
    "Paramètres"
  ];*/

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
