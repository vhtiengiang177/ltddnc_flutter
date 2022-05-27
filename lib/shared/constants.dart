import 'package:flutter/material.dart';

class ColorCustom {
  static Color primaryColor = Color.fromARGB(255, 255, 179, 0);
  static Color secondaryColor = Color(0xFF666666);
  static Color textPrimaryColor = Color.fromARGB(255, 7, 7, 7);
  static Color inputColor = Color(0xFFEAEAEA);
  static Color selectedColor = Color.fromARGB(255, 253, 253, 253);
  static Color unselectedColor = Color.fromARGB(255, 255, 231, 199);
  static Color buttonSecondaryColor = Color(0xFFE1E1E1);
  static Color buttonSelectedColor = Color.fromARGB(255, 203, 203, 203);
}

const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

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

final imageFailed = "assets/no-image-available.jpg";

final apiHost = "http://7957-1-52-235-222.ngrok.io/api";
