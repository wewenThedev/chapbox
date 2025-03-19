import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../screens/address_list_screen.dart';


class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.profile_2user /*Icons.person*/),
            title: const Text('Profil'),
            onTap: () {
              // Handle navigation
              Navigator.pop(context); // Ferme le Drawer
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.ticket /*Icons.local_offer*/),
            title: const Text('Promotions'),
            onTap: () {
              // Handle navigation
              Navigator.pop(context); // Ferme le Drawer
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.location /*Icons.history*/),
            title: const Text('Adresses'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressListScreen()));
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historique des commandes'),
            onTap: () {

Navigator.pop(context); // Ferme le Drawer
            },),*/
          ListTile(
            leading: const Icon(Iconsax.logout /*Icons.exit_to_app*/),
            title: const Text('Me déconnecter'),
            onTap: () {
//Navigator.pop(context); // Ferme le Drawer
            },
          ),
      
        ],
      ),
    );
  }
}
