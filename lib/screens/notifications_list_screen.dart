import 'package:chapbox/configs/styles.dart';
//import 'package:chapbox/widgets/custom_appBar_title.dart';
import 'package:chapbox/widgets/custom_appBar_with_back.dart';
import 'package:flutter/material.dart';

class NotificationsListScreen extends StatefulWidget {
  const NotificationsListScreen({super.key});

  @override
  State<NotificationsListScreen> createState() => _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBack(title: 'Notifications', scaffoldKey: _scaffoldKey),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: backgroundColor,
              shadowColor: onSecondaryContainerColor,
              elevation: 1.0,
              child: Text('Notification 1'),
            ),
            Card(
              color: backgroundColor,
              shadowColor: onSecondaryContainerColor,
              elevation: 1.0,
              child: Text('Notification 2'),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(items: items),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:chapbox/configs/styles.dart';
//import 'package:chapbox/widgets/custom_appBar_title.dart';
import 'package:chapbox/widgets/custom_appBar_with_back.dart';

import 'package:chapbox/services/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//NotificationScreen
class NotificationsListScreen extends StatefulWidget {
  
  const NotificationsListScreen({super.key});

  @override
  _NotificationsListScreenState createState() => _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  List<dynamic> notifications = [];
  late final int userId;
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    loadNotifications();
    listenToWebSocket();
  }

  void loadNotifications() async {
    List<dynamic> userNotifications = await NotificationService.getUserNotifications(userId);
    setState(() => notifications = userNotifications);
  }

  /// Charger les notifications locales et synchroniser avec l'API
  /*void loadNotifications() async {
    List<Map<String, dynamic>> cachedNotifications =
        await NotificationService.getCachedNotifications();
    setState(() => notifications = cachedNotifications);

    await NotificationService.fetchAndCacheNotifications(widget.userId);
    List<Map<String, dynamic>> updatedNotifications =
        await NotificationService.getCachedNotifications();
    setState(() => notifications = updatedNotifications);
  }*/

  /// Marquer une notification comme lue
  void markNotificationAsRead(int id) async {
    await NotificationService.markAsRead(id);
    loadNotifications();
  }


  void listenToWebSocket() {
    channel = NotificationService.connectWebSocket();
    channel.stream.listen((message) {
      loadNotifications(); // Recharge la liste en cas de nouvelle notification
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(notification['is_read'] == 1
                ? Icons.notifications_none
                : Icons.notifications_active, color: notification['is_read'] == 1 ? appLightGrey : primaryColor),

            title: Text(notification['title']),
            subtitle: Text(notification['message']),
            trailing: notification['is_read'] //== 1
                ? Icon(Icons.check, color: Colors.green)
                : IconButton(
                    icon: Icon(Icons.mark_email_read),
                    onPressed: () async {
                      await NotificationService.markAsRead(notification['id']);
                      loadNotifications();
                    },
                  ),
          );
        },
      ),
    );
  }
}

*/