/**
 * Main.dart
 * 
 * Execution of the program will start here. This page will not be 
 * displayed in any of the application since main.dart redirects
 * the app to our DashBoardUi page as the home page.
 */
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/dashboard.dart';

void main() {
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
      home: DashboardUI(),
    );
  }
}
