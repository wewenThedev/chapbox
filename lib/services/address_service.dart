import 'package:http/http.dart' as http;
import 'dart:convert';


Class GeocodeService {
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    Final response = await http.get(Uri.parse($BASE_URL.'geocode?address=$address'));
    
    If (response.statusCode == 200) {
      Final jsonResponse = json.decode(response.body);
      Final location = jsonResponse['results'][0]['geometry']['location'];
      Return LatLng(location['lat'], location['lng']);
    } else {
      Throw Exception('Failed to load coordinates');
    }
  }
}
