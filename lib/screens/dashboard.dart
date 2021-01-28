import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class DashboardUI extends StatefulWidget {
  // here i will have my welcome message, and stock, attention, pencils and ens, erases
  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: _buildDashboard(),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

  Widget _buildDashboard() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView(
        children: <Widget>[
          Container(
            child: new Text(
              "Welcome",
              style: TextStyle(
                fontSize: 60,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          new Text(
            "Bellow is your summary",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(bottom:80)),
          Container(
            child: Text("hello world"),
          ),
        ],
      ),
    );
  }
} // end of class
