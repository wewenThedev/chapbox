import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//à modifier
class CartService {
  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    return deviceId;
  }

  Future<void> addToCart(int productId) async {
    String deviceId = await getDeviceId();
    var response = await http.post(
      Uri.parse('https://your-api-url.com/api/add-to-cart'),
      body: jsonEncode({
        'device_id': deviceId,
        'product_id': productId,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Product added to cart');
    } else {
      print('Failed to add product');
    }
  }
}
