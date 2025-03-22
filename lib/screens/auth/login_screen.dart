import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/screens/on_boarding/steps_screen.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:chapbox_new/utils/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/widgets/custom_button.dart';
import 'package:chapbox/widgets/custom_textField.dart';
import 'package:chapbox/screens/auth/forgot_password_screen.dart';
import 'package:chapbox/screens/auth/otp_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:chapbox/services/auth_service.dart';
import 'package:chapbox/screens/home_screen.dart'; // L'écran vers lequel on redirige après connexion

//based on register

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /*navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }*/
  final TextEditingController _pnController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  //TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    const String apiUrl =
        'http://127.0.0.1:8001/api/login/customer'; // Change for real devices
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email_or_phone': _pnController.text,
        'password': _pwdController.text,
      },
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);
      // Vérifiez si c'est une liste ou un objet contenant une liste
      final List<dynamic> data =
          jsonList is List ? jsonList : jsonList['token'] ?? [];
      // String token = (String) data['token'];
      //final token = data['token'].toString();
//à modifier
      /*final token = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);*/

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Connexion réussie"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpScreen()));
    } else {
      //_showErrorDialog(data['message']);
      /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Identifiants de connexion incorrects"),
      ));*/
    }
  }

  /// ❌ Affiche une erreur si la connexion échoue
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Erreur"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

/*void loginUser() async {
  Map<String, dynamic> response = await UserService.createUser({
    'name': 'John Doe',
    'email': 'john@example.com',
    'password': 'password123'
  });

  print(response);
}*/

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons
              .arrow_back_ios /*Iconsax.arrow_left_1*/ /*LineIcons.arrowLeft*/),
          onPressed: () {
            Navigator.maybePop(
                context, MaterialPageRoute(builder: (context) => StepScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: media.width * 0.1, horizontal: media.width * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'logos/logo_chapbox_pin.png',
                    height: 75,
                    width: 75,
                  ),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Text(
                  'Connectez-vous',
                  textAlign: TextAlign.center,
                  style: ChapboxTheme.lightTheme.textTheme.headlineLarge,
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                Container(),
                MyTextField(
                    controller: _pnController,
                    hintText: 'Numéro de téléphone',
                    type: TextInputType.phone
                    //validator: value

                    ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                /*MyTextField(
                  controller: emailController,
                  hintText: 'Adresse mail',
                  labelName: 'Adresse mail',
                  type: TextInputType.emailAddress),
              SizedBox(
                height: media.width * 0.05,
              ),*/
                MyTextField(
                    controller: _pwdController,
                    hintText: 'Mot de passe',
                    type: TextInputType.visiblePassword,
                    isTextObscure: true
                    //validator: value

                    ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    primaryColor /*const Color.fromARGB(255, 148, 84, 84)*/,
                                foregroundColor: Colors.white,
                                elevation: 0.0,
                                fixedSize: Size(
                                    media.width * 0.75, media.height * 0.06),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                //side: ,
                              ),
                              onPressed: () {
                                _login;

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpScreen()));
                              },
                              child: Text(
                                'Connectez-vous',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            style: ButtonStyle(
                                textStyle: WidgetStatePropertyAll(
                                    TextStyle(fontStyle: FontStyle.normal))),
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontStyle: FontStyle.normal),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
return Row(
      mainAxisAlignment: MainAxisAlignment.end, //can change
      children: [
        TextButton(
            onPressed: () {},
            style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    /*decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: primaryColor*/))),
            child: Text('Mot de passe oublié ?')),
      ],
    );
*/
