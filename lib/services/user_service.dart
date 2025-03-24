import 'dart:convert';
import 'package:chapbox/services/api_service.dart';
import 'package:chapbox/configs/const.dart';




class UserService {
  static Future<List<dynamic>> getUsers() async {
    final response = await ApiService.get("users");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getUser(int id) async {
    final response = await ApiService.get("users/$id");
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final response = await ApiService.post("users", userData);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> updateUser(int id, Map<String, dynamic> userData) async {
    final response = await ApiService.put("users/$id", userData);
    return jsonDecode(response.body);
  }

  static Future<void> deleteUser(int id) async {
    await ApiService.delete("users/$id");
  }
}

