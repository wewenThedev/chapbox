//based on login

import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/widgets/base_scaffold.dart';
import 'package:chapbox/widgets/custom_button.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController txtOTP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
          width: media.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "Vérification de votre téléphone",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(
                height: media.width * 0.02,
              ),
              Text(
                "Enter your OTP code here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: appDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
              /*OtpTextField(
                numberOfFields: 4,
                borderColor: appGrey,
                focusedBorderColor: primaryColor,
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                showFieldAsBox: false,
                borderWidth: 4.0,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here if necessary
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {},
              ),*/
              SizedBox(
                height: media.width * 0.25,
              ),
              LargeTextButton(
                content: "Verify Now",
                type: ButtonType.elevated,
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BaseScaffold()),);
                              //OtpFieldStyle()
                  /*Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              BaseScaffold()),
                      (route) => true);*/
                },
              ),
            ],
          ),
        )),
      ),
    );
    /*Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LargeTextButton(
            content: 'Mot de passe oublié ?',
            action: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            deviceId: '',
                          )));
            },
            type: ButtonType.text)
      ],
    );*/
  }
}
