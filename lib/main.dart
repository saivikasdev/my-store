
import 'package:flutter/material.dart';
import 'package:gadgets4u/routes.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/login_success/login_success_screen.dart';
import 'package:gadgets4u/screens/profile/profile_screen.dart';
import 'package:gadgets4u/screens/sign_in/sign_in_screen.dart';
import 'package:gadgets4u/screens/sign_up/sign_up_screen.dart';
import 'package:gadgets4u/screens/splash/splash_screen.dart';
import 'package:gadgets4u/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final User=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (User.currentUser != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gadgets4U',
        theme: theme(),

        initialRoute:HomeScreen.routeName,
        routes: routes,
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gadgets4U',
        theme: theme(),

        initialRoute:SplashScreen.routeName,
        routes: routes,
      );
    }


  }
}
