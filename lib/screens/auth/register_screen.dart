import 'dart:convert';

import 'package:chapbox/models/cart.dart';
import 'package:chapbox/widgets/base_scaffold.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/models/user.dart';
import 'package:chapbox/screens/auth/otp_screen.dart';
import 'package:chapbox/screens/auth/login_screen.dart';
import 'package:chapbox/screens/home_screen.dart';
import 'package:chapbox/screens/on_boarding/steps_screen.dart';
import 'package:chapbox/services/auth_service.dart';
import 'package:chapbox/widgets/custom_button.dart';
import 'package:chapbox/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart'; // Pour kIsWeb

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  //final TextEditingController _unController = TextEditingController();
  final TextEditingController _pnController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPwdController =
      TextEditingController(); // Nouveau contrôleur pour la confirmation

  bool _isLoading = false;
  //String? _deviceId;
//_deviceId = await _getDeviceId();

  final _formKey = GlobalKey<FormState>();

  /*Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if () {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown-ios-id';
    }else if(kIsWeb) {
    return 'web-device-${DateTime.now().millisecondsSinceEpoch}';
  }
    return 'unknown-device';
  }*/

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Vérification de la correspondance des mots de passe
      if (_pwdController.text != _confirmPwdController.text) {
        _showErrorDialog("Les mots de passe ne correspondent pas");
        return;
      }

/*if (_deviceId == null) {
      _showErrorDialog(
          "Erreur: Impossible d'obtenir l'identifiant de l'appareil.");
      return;
    }*/
      setState(() => _isLoading = true);

      try {
        //final authService = AuthService(prefs: await SharedPreferences.getInstance());
        //final authService = AuthService;

        final User $user;

        var $response = await AuthService.register(
          firstname: _fnController.text,
          lastname: _lnController.text,
          email: _emailController.text,
          phone: _pnController.text,
          password: _pwdController.text,
          profileId: 3,
          deviceId: 'device-id',
          //deviceId: await _getDeviceId();
        );
        if ($response.statusCode == 201) {
          final jsonResponse = jsonDecode($response.body);
          $user = User.fromJson(jsonResponse['user']);
          $user.cart = Cart.fromJson(jsonResponse['cart']);

          // Succès
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Inscription réussie'),
              content: const Text('Votre compte a été créé avec succès.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BaseScaffold(
                              userConnected: $user,
                              userConnectedCart: $user.cart,
                            )),
                  ),
                  child: const Text('OK'),
                )
              ],
            ),
          );
        } else {
          throw Exception('Erreur d\'inscription: ${$response.body}');
        }
      } catch (e) {
        _showErrorDialog(e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context, // Utilisation du contexte de la classe
      builder: (ctx) => AlertDialog(
        title: const Text("Erreur"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    /*TextEditingController _fnController = TextEditingController();
  TextEditingController _lnController = TextEditingController();
  TextEditingController _pnController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();*/

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(/*Iconsax.arrow_left*/ LineIcons.arrowLeft),
          onPressed: () {
            Navigator.maybePop(
                context, MaterialPageRoute(builder: (context) => StepScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: /*SingleChildScrollView(
        child: */
          Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'logos/logo_chapbox_pin.png',
                height: 150,
                width: 150,
              ),
              /*SizedBox(
                          height: media.width * 0.02,
                          ),*/
              Column(
                children: [
                  Text(
                    'Inscrivez-vous',
                    textAlign: TextAlign.center,
                    style: ChapboxTheme.lightTheme.textTheme.headlineLarge,
                  ),
                ],
              ),
              SizedBox(
                height: media.width * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    MyTextField(
                      controller: _fnController,
                      hintText: 'Prénom',
                      type: TextInputType.name,
                      //validator: value
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    MyTextField(
                      controller: _lnController,
                      hintText: 'Nom',
                      type: TextInputType.name,
                      //validator: value
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    MyTextField(
                      controller: _pnController,
                      hintText: 'Numéro de téléphone',
                      type: TextInputType.phone,
                      //validator: value
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    MyTextField(
                      controller: _emailController,
                      hintText: 'Adresse mail',
                      type: TextInputType.emailAddress,
                      //validator: value
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    MyTextField(
                      controller: _pwdController,
                      hintText: 'Mot de passe',
                      type: TextInputType.visiblePassword,
                      isTextObscure: true,
                      //validator: value
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    // Champ de confirmation de mot de passe corrigé
                    MyTextField(
                      controller: _confirmPwdController, // Nouveau contrôleur
                      hintText: 'Confirmez votre mot de passe',
                      type: TextInputType.visiblePassword,
                      isTextObscure: true,
                    ),
                  ],
                ),
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
                              fixedSize:
                                  Size(media.width * 0.75, media.height * 0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              //side: ,
                            ),
                            onPressed: _register,
                            child: Text(
                              'Créer votre compte',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous avez un compte ?",
                              style: TextStyle(
                                color: appGrey,
                                fontSize: 13,
                                //fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                style: ButtonStyle(
                                    textStyle: WidgetStatePropertyAll(TextStyle(
                                        fontStyle: FontStyle.normal))),
                                child: Text(
                                  'Connectez-vous',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontStyle: FontStyle.normal),
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
