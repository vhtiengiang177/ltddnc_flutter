import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/providers/category_provider.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/splash_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: ((context) => UserProvider())),
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: ((context) => CategoryProvider()))
      ],
      child: Consumer<UserProvider>(
        builder: (context, value, _) {
          return MaterialApp(
              title: 'Burger Bistro',
              theme: ThemeData(
                primarySwatch: Palette.lightTheme,
                textTheme:
                    GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
              ),
              home: SlashScreen());
        },
      ),
    );
  }
}
