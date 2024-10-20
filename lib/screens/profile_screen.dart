import 'package:chapbox/configs/styles.dart';
import 'package:flutter/material.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/models/user.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        //backgroundColor: lightTheme.colorScheme.background,
        backgroundColor: scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 16),
            Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('johndoe@example.com', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
