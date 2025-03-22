import 'dart:convert';

import 'package:chapbox/services/api_service.dart';

class CartService {
  //static Future<List<dynamic>> getCartItems() async {
  static Future<List<dynamic>> getCartItems() async {
    final response = await ApiService.get("cart");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<Map<String, dynamic>> addToCart(
      Map<String, dynamic> cartData /*Map<String, dynamic> product*/) async {
    /*final db = await DatabaseHelper.database;

    // Vérifier si le produit est déjà dans le panier
    List<Map<String, dynamic>> existing = await db.query(
      'cart',
      where: "product_id = ?",
      whereArgs: [product['id']],
    );

    if (existing.isNotEmpty) {
      // Augmenter la quantité
      int newQuantity = existing[0]['quantity'] + 1;
      await db.update(
        'cart',
        {'quantity': newQuantity},
        where: "product_id = ?",
        whereArgs: [product['id']],
      );
    } else {
      // Ajouter un nouveau produit
      await db.insert(
        'cart',
        {
          'product_id': product['id'],
          'name': product['name'],
          'price': product['price'],
          'image': product['image'],
          'quantity': 1
        },
      );
    }
    
    // 🚀 Afficher une notification locale après ajout au panier
    await NotificationHelper.showNotification(
      title: "Produit ajouté !",
      body: "${product['name']} a été ajouté à votre panier.",
    );

    */

    final response = await ApiService.post("cart", cartData);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateCartItem(
      int id, Map<String, dynamic> cartData) async {
    final response = await ApiService.put("cart/$id", cartData);
    return jsonDecode(response.body);
  }

  static Future<void> removeCartItem(int id) async {
    await ApiService.delete("cart/$id");
  }

  static clearCart() {}

  static fetchAndCacheCart() {}

  /*Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin() ;
    String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    return deviceId;
  }*/

  /*Future<void> addToCart(int productId) async {
    //String deviceId = await getDeviceId();
    //String endpoint = $baseUrl.'go';
    print(endpoint);
    var response = await http.post(
      Uri.parse({$baseUrl}."go"),
      body: jsonEncode({
        //'device_id': ,
        /*'user_id' : ,
        'shop_id' : ,*/
        'product_id': productId,
        
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Product added to cart');
    } else {
      print('Failed to add product');
    }
  }*/
}
