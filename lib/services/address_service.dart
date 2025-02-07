import 'package:http/http.dart' as http;
import 'dart:convert';


class GeocodeService {
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    //final response = await http.get(Uri.parse($BASE_URL.'geocode?address=$address'));
    final response = await http.get(Uri.parse('http://127.0.0.1:8001/api/geocode?address=$address'));
    
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