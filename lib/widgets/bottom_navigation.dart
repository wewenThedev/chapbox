import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      //Navigator.push(BuildContext context, route)
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: appLightGrey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      iconSize: 28,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 0
              ? /*Iconsax.home*/ Iconsax.home_1
              : Iconsax.home_1_copy /*LineIcons.home*/ /*Icons.home_filled*/),
          label: 'Accueil',
          backgroundColor: Colors.white,
        ),
        /*BottomNavigationBarItem(
          icon: Icon(selectedIndex == 1 ? Iconsax.search_favorite : Iconsax.search_normal /*LineIcons.search//Icons.search*/),
          label: 'Recherche',
        ),*/
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 2
              ? Iconsax.shopping_cart
              : Iconsax
                  .shopping_cart_copy /*LineIcons.shoppingCart : LineIcons.shoppingCart Icons.shopping_cart*/),
          label: 'Panier',
          backgroundColor: appLightGrey,
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 1
              ? Iconsax.shopping_bag
              : Iconsax
                  .shopping_bag_copy /*Iconsax.ship*/ /*LineIcons.search//Icons.search*/),
          label: 'Commandes',
          backgroundColor: primaryColorLight,
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 3
              ? Iconsax.settings
              : Iconsax
                  .settings_copy /*LineIcons.byName('gear-1') //Icons.settings*/),
          label: 'Paramètres',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
