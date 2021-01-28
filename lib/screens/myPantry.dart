import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class MyPantry extends StatefulWidget {
  @override
  _MyPantryState createState() => _MyPantryState();
}

class _MyPantryState extends State<MyPantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Pantry"),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: MyBottomNaBar(),
    );
    
  }
}