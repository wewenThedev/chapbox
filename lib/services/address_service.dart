import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'api_config.dart';

//Gomaps GéoAPIKey = AlzaSyRBoLxsbdwlOv0Y5bKhdSMmcH2T7zMk6LO

/*
  import 'package:device_info_plus/device_info_plus.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
if (kIsWeb) {
  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  print('Running on : ${webBrowserInfo.platform}');
} else {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on : ${androidInfo.product}');
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on : ${iosInfo.utsname.machine}');
  }
}
 */

class GeocodeService {
  final String baseUrl;
  GeocodeService(this.baseUrl);

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    //final response = await http.get(Uri.parse($baseUrl.'geocode?address=$address'));
    final response = await http.get(Uri.parse("$baseUrl/$address"));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final location = jsonResponse['results'][0]['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

}

  class LatLng{
    String? lat;
    String? long;
    
      LatLng(location1, location2);
    

  }