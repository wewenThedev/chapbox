import 'package:flutter/material.dart';

import 'package:chapbox/widgets/custom_appBar_title.dart';
import 'package:chapbox/widgets/bottom_navigation.dart';
import 'package:chapbox/widgets/drawer_menu.dart';
import 'package:chapbox/configs/themes.dart';

class BaseScaffold extends StatelessWidget {
  final String title; // Titre pour l'AppBar
  final Widget body; // Contenu spécifique à chaque page

  const BaseScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        theme : AppTheme.lightTheme.colorScheme.primary, // Utilise le thème configuré
        title: Text(title),
        // Ajoute d'autres personnalisations ici si nécessaire
      ),
      body: body, // Contenu spécifique à chaque page
      bottomNavigationBar: BottomNavigation(currentIndex: 0, // Index de l'onglet sélectionné
        onTap: ()),
    );
  }
}
