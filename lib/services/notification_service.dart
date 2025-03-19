import 'package:chapbox/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';


class NotificationService {
  static const String apiUrl = "http://127.0.0.0:8001/api";

  static Future<List<dynamic>> getUserNotifications(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/notifications/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur lors du chargement des notifications");
    }
  }

  /*static Future<void> markAsRead(int notificationId) async {
    await http.put(Uri.parse('$apiUrl/notifications/read/$notificationId'));
  }*/

  static IOWebSocketChannel connectWebSocket() {
    return IOWebSocketChannel.connect('ws://127.0.0.0:6001/notifications');
  }

  /// Récupérer les notifications de l'API et les stocker localement
  static Future<void> fetchAndCacheNotifications(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/notifications/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> notifications = jsonDecode(response.body);

      final db = await DatabaseHelper.database;
      await db.transaction((txn) async {
        for (var notification in notifications) {
          await txn.insert(
            'notifications',
            {
              'id': notification['id'],
              'title': notification['title'],
              'message': notification['message'],
              'is_read': notification['is_read'] ? 1 : 0,
              'created_at': notification['created_at'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace, // Remplace si déjà existant
          );
        }
      });
    }
  }

  /// Récupérer les notifications stockées localement
  static Future<List<Map<String, dynamic>>> getCachedNotifications() async {
    final db = await DatabaseHelper.database;
    return await db.query('notifications', orderBy: 'created_at DESC');
  }

  /// Marquer une notification comme lue
  static Future<void> markAsRead(int id) async {
    final db = await DatabaseHelper.database;
    await db.update(
      'notifications',
      {'is_read': 1},
      where: "id = ?",
      whereArgs: [id],
    );

    // Mettre à jour aussi sur le serveur
    await http.put(Uri.parse('$apiUrl/notifications/read/$id'));
  }

}
