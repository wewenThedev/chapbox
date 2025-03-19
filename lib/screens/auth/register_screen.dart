import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/screens/auth/otp_screen.dart';
import 'package:chapbox/screens/auth/login_screen.dart';
import 'package:chapbox/screens/on_boarding/steps_screen.dart';
import 'package:chapbox/widgets/custom_button.dart';
import 'package:chapbox/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    TextEditingController fnController = TextEditingController();
    TextEditingController lnController = TextEditingController();
    TextEditingController pnController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left /*LineIcons.arrowLeft*/),
          onPressed: () {
            Navigator.maybePop(
                context, MaterialPageRoute(builder: (context) => StepScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                child:Column(
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
              /*TextFormField(textAlign: TextAlign.center,),
            TextField()
          */
              /*SizedBox(
                  height: media.width * 0.1,
                ),*/
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: media.width * 0.1, horizontal: media.width * 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeTextButton(
                        content: 'Créer votre compte',
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen()));
                        },
                        type: ButtonType.elevated),
                    SizedBox(
                      height: media.width * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LargeTextButton(
                            content: 'Connectez-vous', //Vous avez un compte ? \n  !
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            type: ButtonType.text),
                      ],
                    ),
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
