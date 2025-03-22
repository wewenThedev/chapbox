import 'package:flutter/material.dart';

enum ButtonType { outlined, elevated, text }

class LargeTextButton extends StatelessWidget {
  final String content;
  final VoidCallback? action;
  final ButtonType type;

  const LargeTextButton(
      {super.key,
      required this.content,
      required this.action,
      required this.type});

/*
ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white/*const Color.fromARGB(255, 148, 84, 84)*/,
                    foregroundColor: primaryColor,
                    elevation: 0.0,
                    fixedSize: Size(media.width*0.75, media.height*0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                    //side: ,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(/*deviceId: '',*/)));
                  },
                  child: Text(
                    'S\'inscrire',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor),
                  ),
                ), */

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.elevated) {
      return ElevatedButton(
        onPressed: action,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          content,
          textAlign: TextAlign.center,
          //style: TextStyle(fontweight: FontWeight.bold),
        ),
      );
    } else if (type == ButtonType.outlined) {
      return OutlinedButton(
        onPressed: action,
        style: Theme.of(context).outlinedButtonTheme.style,
        //style: ChapboxTheme.lightTheme.outlinedButtonTheme.style,
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    } else /*if(type == ButtonType.text)*/ {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.75, // Largeur max
        height: MediaQuery.of(context).size.height * 0.02,
        child: TextButton(
          onPressed: action,
          style: Theme.of(context).textButtonTheme.style,
          //style: ChapboxTheme.lightTheme.textButtonTheme.style,
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}

class SmallTextButton extends StatelessWidget {
  final String content;
  final VoidCallback? action;
  final ButtonType type;

  const SmallTextButton(
      {super.key,
      required this.content,
      required this.action,
      required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.elevated) {
      return ElevatedButton(
        onPressed: action,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    } else if (type == ButtonType.outlined) {
      return OutlinedButton(
        onPressed: action,
        style: Theme.of(context).outlinedButtonTheme.style,
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      );
    } else /*if(type == ButtonType.text)*/ {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.75, // Largeur max
        height: MediaQuery.of(context).size.height * 0.02,
        child: TextButton(
          onPressed: action,
          style: Theme.of(context).textButtonTheme.style,
          //style: ChapboxTheme.lightTheme.textButtonTheme.style,
          child: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}

class AnimatedTextButton extends StatelessWidget {
  const AnimatedTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
