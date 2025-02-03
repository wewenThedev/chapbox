import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String phone = "";
  String email = "";
  List<dynamic> addresses = [];
  List<dynamic> orderHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    // Remplace par l'URL de ton API
    final response = await http.get(Uri.parse('https://api.example.com/user/profile'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        name = data['name'];
        phone = data['phone'];
        email = data['email'];
        addresses = data['addresses'];
        orderHistory = data['order_history'];
      });
    } else {
      // Gérer l'erreur si la récupération échoue
      print("Erreur de récupération des données utilisateur");
    }
  }

  void _logout() {
    // Logique de déconnexion
    // Par exemple, effacer le token d'authentification et naviguer vers la page de connexion
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom: $name", style: TextStyle(fontSize: 18)),
            Text("Numéro de téléphone: $phone", style: TextStyle(fontSize: 18)),
            Text("Email: $email", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(	
              onPressed: () {
                // Logique pour modifier les informations du profil
              },
              child: Text("Modifier mes informations"),
            ),
            SizedBox(height: 20),
            Text("Adresses de livraison:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            /*Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(addresses[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Logique pour supprimer l'adresse
                      },
                    ),
                  );
                },
              ),
            ),*/
            SizedBox(height: 20),
            Text("Historique des commandes:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            /*Expanded(
              child: ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Commande ${orderHistory[index]['id']}"),
                    subtitle: Text("Statut: ${orderHistory[index]['status']}"),
                    onTap: () {
                      // Logique pour voir les détails de la commande
                    },
                  );
                },
              ),
            ),*/
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text("Se déconnecter"),
              /*style: ElevatedButton.styleFrom(
              color : Colors.red, // Couleur rouge pour la déconnexion
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}


//---Old Profile Screen
/*
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
              backgroundImage: AssetImage('images/user_avatar.png'),
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
*/