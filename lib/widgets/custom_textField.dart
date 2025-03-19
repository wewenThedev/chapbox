import 'package:chapbox/configs/themes.dart';
import 'package:flutter/material.dart';

//enum FieldType { name, email, phoneNumber, password }

class MyTextField extends StatelessWidget {
  //final String? labelName;
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
      //required this.labelName,
      this.isTextObscure = false,
      //this.validator,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: TextField(
        /*keyboardType: type == FieldType.name
            ? TextInputType.name
            : type == FieldType.email
                ? TextInputType.emailAddress
                : type == FieldType.phoneNumber
                    ? TextInputType.phone
                    : type == FieldType.password
                        ? TextInputType.visiblePassword
                        : TextInputType.text,*/
        keyboardType: type,
        decoration: InputDecoration(
          //label: Text.rich(textSpan),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          //labelText: labelName,
          hintText: hintText,
        ),
        style: ChapboxTheme.lightTheme.textTheme.bodySmall,
        /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },*/
        //strutStyle: StrutStyle.fromTextStyle(textStyle),
      ),
    );
  }
}
