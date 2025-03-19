/*import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Panier vide');
  }
}*/


import 'package:flutter/material.dart';
import 'package:chapbox/services/cart_service.dart';

import 'package:web_socket_channel/io.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {

List<Map<String, dynamic>> cartItems = [];
final channel = IOWebSocketChannel.connect('ws://127.0.0.0:6001/cart-channel');

  List<Map<String, dynamic>>? get items => null;


  @override
  void initState() {
    super.initState();
    //loadCart();
    channel.stream.listen((event) async {
      await CartService.fetchAndCacheCart(); // Mettre à jour le cache
      setState(() {});
    });

  }

void loadCart() async {
    //List<Map, dynamic> items = await CartService.getCartItems();
    List items = await CartService.getCartItems();
    //setState(() => cartItems = items);
  }

  void removeItem(int productId) async {
    await CartService.removeCartItem(productId);
    loadCart();
  }

  void clearCart() async {
    await CartService.clearCart();
    loadCart();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Mon panier")),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: Image.network(item['image'], width: 50, height: 50, fit: BoxFit.cover),
            title: Text(item['name']),
            subtitle: Text("${item['price']} € x ${item['quantity']}"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeItem(item['product_id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearCart,
        backgroundColor: Colors.red,
        child: Icon(Icons.delete),
      ),
    );
  }
}
//List<Ad> _ads = rawData.map<Ad>((Map<String, dynamic> e) => Ad.fromJson(e)).toList() as List<Ad>;