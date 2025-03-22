//based on login

import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/screens/auth/login_screen.dart';
import 'package:chapbox/screens/auth/otp_screen.dart';
import 'package:chapbox/widgets/custom_button.dart';
import 'package:chapbox/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    TextEditingController pnController = TextEditingController();
    //TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax
              .arrow_left /*Iconsax.arrow_left_1*/ /*LineIcons.arrowLeft*/),
          onPressed: () {
            Navigator.maybePop(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
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
              Text(
                'Réinitialiser le mot de passe',
                textAlign: TextAlign.center,
                style: ChapboxTheme.lightTheme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
              Column(
                children: [
                  Text(
                    'Saisissez votre numéro pour obtenir le code de réintiialisation',
                    textAlign: TextAlign.center,
                    style: ChapboxTheme.lightTheme.textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: media.width * 0.1,
                  ),
                  MyTextField(
                      controller: pnController,
                      hintText: 'Numéro de téléphone',
                      type: TextInputType.phone),
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
                  /*TextFormField(textAlign: TextAlign.center,),
            TextField()
          */
                ],
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              LargeTextButton(
                  content: 'Obtenir le code',
                  action: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpScreen()));
                  },
                  type: ButtonType.elevated),
            ],
          ),
        ),
      ),
    );
  }
}
