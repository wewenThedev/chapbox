import 'package:chapbox/screens/notifications_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:chapbox/configs/styles.dart';

class CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath =
      'assets/logos/logo_chapbox_pin.png'; // Le chemin du logo comme étant AssetImage
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Le constructeur pour accepter le logo et la clé du Scaffold pour ouvrir le Drawer
  const CustomLogoAppBar(
      {super.key, /*required this.logoPath,*/ required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /*leading: IconButton(
        icon: Icon(/*Icons.menu*/ Iconsax.menu_copy, color: appGrey, size: 35.0),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer(); // Ouvre le Drawer
        },
      ),*/
      title: Image(
        image: AssetImage(logoPath),
        height: 90,
        fit: BoxFit.contain,
      ),
      centerTitle: true, // Centre le logo au milieu de l'AppBar
      actions: [
        IconButton(
          icon: Icon(Iconsax.notification /*Icons.notifications*/,
              color: appLightGrey, size: 40.0),
          onPressed: () {
            //print('Notifications button clicked');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsListScreen()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
