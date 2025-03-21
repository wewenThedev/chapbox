import 'package:chapbox/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:chapbox/services/shop_service.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({super.key});

  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  List<dynamic> shops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadShops();
  }

  /// Charger les boutiques du cache et actualiser avec l'API
  void loadShops() async {
    // Charger d'abord depuis SharedPreferences (cache rapide)
    List<dynamic> cachedShops = await ShopService.getShopsFromCache();
    if (cachedShops.isNotEmpty) {
      setState(() => shops = cachedShops);
    }

    // Charger ensuite depuis la base de données locale (si pas de cache rapide)
    if (shops.isEmpty) {
      List<Map<String, dynamic>> dbShops = await ShopService.getCachedShops();
      setState(() => shops = dbShops);
    }

    // Mettre à jour avec les données récentes de l'API
    await ShopService.fetchAndCacheShops();
    List<Map<String, dynamic>> updatedShops = await ShopService.getCachedShops();
    setState(() {
      shops = updatedShops;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boutiques")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : shops.isEmpty
              ? Center(child: Text("Aucune boutique disponible"))
              : ListView.builder(
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final shop = shops[index];
                    return ListTile(
                      title: Text(shop['name']),
                      subtitle: Text(shop['location'] ?? "Localisation inconnue"),
                      trailing: Icon(Icons.store),
                      onTap: () {
                        // Naviguer vers les produits de la boutique (ex: ShopProductsScreen)
                      },
                    );
                  },
                ),
    );
  }
}
