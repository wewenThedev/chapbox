import 'dart:convert';
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
