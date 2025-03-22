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
  bool _isLoading = false;
  String _errorMessage = '';

  /*final channel =
      IOWebSocketChannel.connect('ws://127.0.0.0:6001/cart-channel');

  List<Map<String, dynamic>>? get items => null;*/

  @override
  void initState() {
    super.initState();
    loadCart();
    //channel.stream.listen((event) async {
    //await CartService.fetchAndCacheCart(); // Mettre à jour le cache
    setState(() {});
    //});
  }

  void loadCart() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      //List<Map, dynamic> items = await CartService.getCartItems();
      List items = await CartService.getCartItems();
      setState(() => _isLoading = false);
      //setState(() => cartItems = items);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void removeItem(int productId) async {
    await CartService.removeCartItem(productId);
    loadCart();
  }

  void clearCart() async {
    await CartService.clearCart();
    loadCart();
  }

  Widget _buildEmptyCart() {
    return SingleChildScrollView(
      // Permet le scroll même quand vide
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 100,
                color: Colors.grey[400],
              ),
              SizedBox(height: 20),
              Text(
                'Votre panier est vide',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ajoutez des produits pour commencer vos achats !',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                leading: Image.network(item['image'],
                    width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item['name']),
                subtitle: Text(
                    "${item['price'].toStringAsFixed(2)} € x ${item['quantity']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => removeItem(item['product_id']),
                ),
              );
            },
          ),
          FloatingActionButton(
            elevation: 2.0,
            onPressed: clearCart,
            backgroundColor: Colors.red,
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Erreur : $_errorMessage'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: loadCart,
            child: Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mon panier")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : cartItems.isEmpty
                  ? _buildEmptyCart()
                  : _buildCartList(),
    );

    /*
    RefreshIndicator(
        onRefresh: _fetchCartItems, // Utilise la même fonction de rafraîchissement
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? _buildErrorWidget()
                : _buildContent(),
      ),
    );
    */
  }
}
//List<Ad> _ads = rawData.map<Ad>((Map<String, dynamic> e) => Ad.fromJson(e)).toList() as List<Ad>;
