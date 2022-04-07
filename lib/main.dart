import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/widgets/splash-screen.dart';
import 'package:ltddnc_flutter/shared/constant.dart';
import 'package:ltddnc_flutter/widgets/login-screen.dart';
import 'package:ltddnc_flutter/widgets/register-screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: key,
      providers: [
        ChangeNotifierProvider(create: ((context) => UserProvider()))
      ],
      child: Consumer<UserProvider>(
        builder: (context, value, _) {
          return MaterialApp(
              title: 'Food App',
              theme: ThemeData(
                primarySwatch: Palette.lightTheme,
                textTheme:
                    GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
              ),
              home: SlashScreen());
        },
      ),
    );
  }
}