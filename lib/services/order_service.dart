import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:chapbox/services/api_service.dart';


class OrderService {
  static Future<List<dynamic>> getOrders() async {
    final response = await ApiService.get("orders");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getOrder(int id) async {
    final response = await ApiService.get("orders/$id");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    final response = await ApiService.post("orders", orderData);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateOrder(int id, Map<String, dynamic> orderData) async {
    final response = await ApiService.put("orders/$id", orderData);
    return jsonDecode(response.body);
  }

  static Future<void> deleteOrder(int id) async {
    await ApiService.delete("orders/$id");
  }

  //

  Future createOrderParticular(isUserConnected, data) async {

  //if
  if(isUserConnected){

    final body = {
    "userId" : data['userId'],
    "shopId" : data['shopId'],
    "guest_firstname" : "",
    "guest_lastname" : "",
    "guest_phone" : "",
    "guest_email" : "",
    "total_ht" : data['total_ht'],
    "total_ttc" : data['total_ttc'],
    "shipping_date" : DateTime.now().toString(),
    "shipping_address" : data['shipping_address'],
  };

  final url = '127.0.0.1:8001/api/orders';
  final uri = Uri.parse(url);
  final response = await http.post(uri, headers: {

  }, body: body);

  /*await NotificationHelper.scheduleNotification(
  title: "Commande en cours",
  body: "Votre commande sera livrée dans quelques minutes.",
  seconds: 600, // 10 minutes
);*/

    return  response.statusCode;

  }else{

  }
  

}



}
