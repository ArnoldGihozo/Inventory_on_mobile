/**
 * MyBottomNavBar.dart
 * 
 * This class will build our bottom nav bar that you can see on all the screens.
 * It will also map each button on the bottom nav bar to the specifc route
 * it has to go (ie: which page is the app redirected)
 * 
 * Date Last Modified: January 29 2021
 */

import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/dashboard.dart';
import 'package:inventory_on_mobile/screens/toolBox.dart';

class MyBottomNaBar extends StatefulWidget {
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNaBar> {
  Color _originalColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.only(top: 2, bottom: 30),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 38.0,
            ),
            onPressed: () {
              Icon(Icons.home, size: 38.0, color: Colors.grey);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardUI()),
              );
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.bar_chart_outlined, size: 38.0),
            onPressed: () {
              setState:
              () {
                if (_originalColor == Colors.black) {
                  _originalColor = Colors.green;
                  icon:
                  Icon(Icons.calendar_today, color: Colors.green, size: 38.0);
                } else {
                  _originalColor = Colors.pink;
                }
              };

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToolBox()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
