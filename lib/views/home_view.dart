import 'package:chapbox/main.dart';

Column(
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Image.asset(
              'assets/logo_one.png',
              alignment: Alignment.center,
              height: 72,
            ),
          ),
        ],
      ),
    ),
  ],
)
