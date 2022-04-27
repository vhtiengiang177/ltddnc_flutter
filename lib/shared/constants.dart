import 'package:flutter/material.dart';

class ColorCustom {
  static Color primaryColor = Color(0xFFFFB300);
  static Color secondaryColor = Color(0xFF666666);
  static Color textPrimaryColor = Color.fromARGB(255, 7, 7, 7);
  static Color inputColor = Color(0xFFEAEAEA);
  static Color selectedColor = Color.fromARGB(255, 253, 253, 253);
  static Color unselectedColor = Color.fromARGB(255, 255, 231, 199);
  static Color buttonSecondaryColor = Color(0xFFE1E1E1);
  static Color buttonSelectedColor = Color.fromARGB(255, 203, 203, 203);
}

class Palette {
  static MaterialColor lightTheme = const MaterialColor(
    0xFFFFB300,
    <int, Color>{
      50: Color(0xffffbb1a), //10%
      100: Color(0xffffc233), //20%
      200: Color(0xffffca4d), //30%
      300: Color(0xffffd166), //40%
      400: Color(0xffffd980), //50%
      500: Color(0xffffe199), //60%
      600: Color(0xffffe8b3), //70%
      700: Color(0xfffff0cc), //80%
      800: Color(0xfffff7e6), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static MaterialColor darkTheme = const MaterialColor(
    0xFFFFB300,
    <int, Color>{
      50: Color(0xffe6a100), //10%
      100: Color(0xffcc8f00), //20%
      200: Color(0xffb37d00), //30%
      300: Color(0xff996b00), //40%
      400: Color(0xff805a00), //50%
      500: Color(0xff664800), //60%
      600: Color(0xff4c3600), //70%
      700: Color(0xff332400), //80%
      800: Color(0xff191200), //90%
      900: Color(0xff000000), //100%
    },
  );
}

final imageFailed =
    "https://firebasestorage.googleapis.com/v0/b/ltddnc-flutter.appspot.com/o/no-image-available.jpg?alt=media&token=af6d074d-e58e-4cf1-98a1-de1f4cca1e3b";

final apiHost =
    "http://fa26-2402-800-6375-1606-711a-b698-5f7e-6a2d.ngrok.io/api";
