import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/providers/auth_provider.dart';
import 'package:ltddnc_flutter/screens/splash-screen.dart';
import 'package:ltddnc_flutter/shared/constant.dart';
import 'package:ltddnc_flutter/widgets/login-screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserProvider()))
      ],
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, snapshot) {
                return MaterialApp(
                  title: 'Food App',
                  theme: ThemeData(
                    primarySwatch: Palette.lightTheme,
                    textTheme:
                        GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
                  ),
                  home: snapshot.connectionState == ConnectionState.done
                      ? LoginScreen()
                      : SlashScreen(),
                );
              });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Hello"),
    ));
  }
}
