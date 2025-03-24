/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  static const String _apiUrl = "http://127.0.0.1:8001/api/registerCustomer";

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /*static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }*/

  ///Fonction d'inscription de l'utilisateur
  static Future<Map<String, dynamic>> registerCustomer(
      String firstname,
      String lastname,
      //String username,
      String email,
      String phone,
      String password,
      String deviceId) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstname": firstname,
          "lastname": lastname,
          //"username": username,
          "email": email,
          "phone": phone,
          "password": password,
          "profile_id": 3, // Customer
          "device_id": deviceId,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        //await _saveUserId(responseData['id']); // 🔐 Stocker l'ID utilisateur
        return {"success": true, "message": "Inscription réussie !"};
      } else {
        return {
          "success": false,
          "message": responseData['message'] ?? "Une erreur est survenue"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Erreur de connexion au serveur"};
    }
  }

  /// 📌 Fonction de connexion de l'utilisateur
  static Future<Map<String, dynamic>> loginCustomer(
      String emailOrPhone, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email_or_phone": emailOrPhone,
          "password": password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData.containsKey('token')) {
        String token = responseData['token'];
        await _saveToken(token); // 🔐 Stocker le token
        await _saveUserInfo(
            responseData['user']); // 💾 Stocker les infos utilisateur

        return {"success": true, "message": "Connexion réussie !"};
      } else {
        return {
          "success": false,
          "message": responseData['email']?.first ?? "Identifiants incorrects"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Erreur de connexion au serveur"};
    }
  }

  /// 🔐 Sauvegarde du token d'authentification
  static Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
  }

  /// 💾 Sauvegarde des informations utilisateur en cache
  static Future<void> _saveUserInfo(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_data", jsonEncode(user));
  }

  /// 🔑 Récupérer le token stocké
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  /// 🚪 Déconnexion de l'utilisateur
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
    await prefs.remove("user_data");
  }

  //Sauvegarde de l'ID utilisateur en cache
  static Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", userId);
  }
}

*/

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chapbox/models/user.dart';

class AuthService {
  static const String _baseUrl = 'http://127.0.0.1:8001/api';
  final SharedPreferences? prefs;

  AuthService(this.prefs);

  // Enregistrement
  static Future register({
    required String firstname,
    required String lastname,
    String? username,
    required String email,
    required String phone,
    required String password,
    required int profileId,
    String? deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register/customer'),
      body: jsonEncode({
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
        'profile_id': profileId,
        'device_id': deviceId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
    /*if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw _handleError(response);*/
  }

  // Connexion
  Future<String> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/customer'),
      body: jsonEncode({
        'email_or_phone': emailOrPhone,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveToken(data['token']);
      return data['token'];
    }
    throw _handleError(response);
  }

  // Déconnexion
  Future<void> logout() async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      await prefs!.remove('auth_token');
    } else {
      throw _handleError(response);
    }
  }

  // Récupérer l'utilisateur connecté
  Future<User> getCurrentUser() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw _handleError(response);
  }

  // Gestion du token
  Future<void> _saveToken(String token) async {
    await prefs!.setString('auth_token', token);
  }

  Future<String?> _getToken() async {
    return prefs!.getString('auth_token');
  }

  // Gestion des erreurs
  Never _handleError(http.Response response) {
    final error = jsonDecode(response.body)?['error'] ?? 'Erreur inconnue';
    throw Exception('${response.statusCode} - $error');
  }
}

/*
// Dans votre provider/Bloc
Future<void> loginUser(String email, String password) async {
  try {
    final token = await authService.login(email, password);
    _currentUser = await authService.getCurrentUser();
    notifyListeners();
  } catch (e) {
    throw Exception('Échec de connexion: $e');
  }
}

Future<String> refreshToken() async {
  final response = await http.post(
    Uri.parse('$_baseUrl/refresh-token'),
    headers: {'Authorization': 'Bearer ${await _getToken()}'},
  );
  // Implémentez la logique de rafraîchissement
  
}
*/
