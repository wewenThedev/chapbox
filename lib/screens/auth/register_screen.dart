import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /*navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }*/
  final TextEditingController fnController = TextEditingController();
  final TextEditingController lnController = TextEditingController();
  final TextEditingController pnController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  String? _deviceId;

  /// 🔹 Fonction pour gérer l'inscription
  Future<void> _register() async {
    /*if (_deviceId == null) {
      _showErrorDialog(
          "Erreur: Impossible d'obtenir l'identifiant de l'appareil.");
      return;
    }*/

    setState(() => _isLoading = true);
    final result = await AuthService.registerCustomer(
      fnController.text,
      lnController.text,
      //_usernameController.text,
      emailController.text,
      pnController.text,
      pwdController.text,
      _deviceId!,
    );
    setState(() => _isLoading = false);

    if (result['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showErrorDialog(result['message']);
    }
  }

  ///Affiche une erreur si l'inscription échoue
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    /*TextEditingController fnController = TextEditingController();
    TextEditingController lnController = TextEditingController();
    TextEditingController pnController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    TextEditingController emailController = TextEditingController();*/

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
          SafeArea(
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
                    controller: fnController,
                    hintText: 'Prénom',
                    type: TextInputType.name,
                    //validator: value
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  MyTextField(
                    controller: lnController,
                    hintText: 'Nom',
                    type: TextInputType.name,
                    //validator: value
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  MyTextField(
                    controller: pnController,
                    hintText: 'Numéro de téléphone',
                    type: TextInputType.phone,
                    //validator: value
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Adresse mail',
                    type: TextInputType.emailAddress,
                    //validator: value
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  MyTextField(
                    controller: pwdController,
                    hintText: 'Mot de passe',
                    type: TextInputType.visiblePassword,
                    isTextObscure: true,
                    //validator: value
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  MyTextField(
                    controller: fnController,
                    hintText: 'Confirmez votre mot de passe',
                    type: TextInputType.visiblePassword,
                    isTextObscure: true,
                    //validator: value
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
                          onPressed: () {
                            _register();
                          },
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
                                  textStyle: WidgetStatePropertyAll(
                                      TextStyle(fontStyle: FontStyle.normal))),
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
    );
  }
}
