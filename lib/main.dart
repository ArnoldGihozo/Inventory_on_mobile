/**
 * Main.dart
 * 
 * Execution of the program will start here. This page will not be 
 * displayed in any of the application since main.dart redirects
 * the app to our DashBoardUi page as the home page.
 * 
 * Date Last Modified: January 29 2021
 */
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/dashboard.dart';
import 'package:inventory_on_mobile/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
    );
  }
}
