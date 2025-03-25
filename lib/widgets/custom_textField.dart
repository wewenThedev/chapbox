import 'package:chapbox/configs/themes.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isTextObscure;
  //final validator
  //final FieldType type;
  final TextInputType type;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isTextObscure = false,
      //this.validator,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: TextField(
        keyboardType: type,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          hintText: hintText,
        ),
        style: ChapboxTheme.lightTheme.textTheme.bodySmall,
        /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ce champ ne peut pas etre vide";
                    }
                    return null;
                  },*/
        //strutStyle: StrutStyle.fromTextStyle(textStyle),
      ),
    );
  }
}



//enum FieldType { name, email, phoneNumber, password }

        /*keyboardType: type == FieldType.name
            ? TextInputType.name
            : type == FieldType.email
                ? TextInputType.emailAddress
                : type == FieldType.phoneNumber
                    ? TextInputType.phone
                    : type == FieldType.password
                        ? TextInputType.visiblePassword
                        : TextInputType.text,*/