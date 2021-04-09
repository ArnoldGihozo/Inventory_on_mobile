/**
 * Dashboard.Dart
 * 
 * This screen is the HomePage of our application. It contains an overview
 * of items that are in low in stock, total items in stock and the trends 
 * within your inventory (ie: overview of each category)
 * 
 * Throughout this file, you will observe that UI elements have been split into function
 * for better visualisation and overall clean code. 
 * 
 * Date Last Modified: January 29 2021
 */
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/services/apiService.dart';
import 'package:inventory_on_mobile/services/authentication.dart';
import 'package:inventory_on_mobile/services/item.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class DashboardUI extends StatefulWidget {
  // here i will have my welcome message, and stock, attention, pencils and ens, erases
  DashboardUI({Key key}) : super(key: key);
  @override
  _DashboardUIState createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  List<Item> items;
  String low = "0";
  String itemCategory = "0";
  var inStockController = TextEditingController();
  String userName = AuthenticationService.userNameS;
/**
 * UI execution starts here
 */
  @override
  Widget build(BuildContext context) {
    _getItems();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: items == null // there is case our elements are loading
          ? Center(
              child: Text('Loading your pantry ...'),
            )
          : _buildDashboardUI(),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }
  // ======================================================================
  // MAIN BODY FOR Dashboard Building

/**
 * _buildDashboardUi() -> widget
 * 
 * This function is the main function that builds the elements on the dashboard screen. 
 * It is called in the main widget and returns a Safearea widget that contains 
 * the methods that builds the textboxes on the screen
 */
  Widget _buildDashboardUI() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          _paddingTextWelcome("Hello, ", userName),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20.0,
                children: <Widget>[
                  _bigTextBox("Attention", _lowInventory(items.length),
                      " item(s) are low in stock", Colors.yellow[800]),
                  _bigTextBox("In Stock", items.length.toString(), " item(s)",
                      Colors.black),
                  _paddingText("     Your Current Trends"),
                  SizedBox(height: 50),
                  _smallTextBox("Leisure", _categoryTrend(1), Colors.red),
                  _smallTextBox("School", _categoryTrend(3), Colors.blue),
                  _smallTextBox("Office", _categoryTrend(2), Colors.black)
                ],
              ),
            ),
          )
        ],
      ),
    );
  } // buildDashboardUI

// =========================================================================================
// Functions that build textboxes  on screen

/**
 * _paddingText(String) -> Widget
 * 
 * This function is there to faciliate clean code. Given a string, it returns the customization
 * padding with the given text included. Used since the same customization is used
 * for "welcome" and "your current trends" texts
 * 
 * 
 */
  Widget _paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  } //_paddingText
Widget _paddingTextWelcome(String text, String usName) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text + " " + usName,
        style: TextStyle(
            color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
/**
 * _bigTextBox(String, String, String, Color) -> SizedBox
 * 
 * This functions takes in as parameter a string title text, number to display as 
 * type string, trailling text as type string and color. The function will
 * then return a sized box with the above customization. 
 */
  Widget _bigTextBox(String titleText, String numberText, String trailingText,
      Color colorBackground) {
    return SizedBox(
      width: 1000.0,
      height: 135.0,
      child: Card(
        color: colorBackground,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                titleText,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                numberText + trailingText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )
            ],
          ),
        )),
      ),
    );
  } // bigText

/**
 * _smallTextBox(String, String, Color) --> SizedBod(Widget)
 * 
 * TThis functions takes in as parameter a string title text, number to display as 
 * type string,and color. The function will
 * then return a sized box with the above customization. 
 */
  Widget _smallTextBox(
      String textBoxTitle, String numItemCat, Color colorBackground) {
    return SizedBox(
      width: 110.0,
      height: 100.0,
      child: Card(
        color: colorBackground,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                textBoxTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                numItemCat + " items",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )),
      ),
    );
  }
// =========================================================================================
// Helper functions that fetch and/or calculate the data needed to be displayed in textboxes

/**
 * _lowInventory(int) -> String
 * 
 * This function takes in an input of the lenght of a given list and returns 
 * the number of items (as type string) that have quantities less than or
 * equal to 2
 * 
 */
  String _lowInventory(int length) {
    int counter = 0;

    for (int i = 0; i < length; i++) {
      if (items[i].itemQuantity <= 3) {
        counter++;
      } // if
    } // fpr
    setState(() {
      low = counter.toString();
    });
    return counter.toString();
  } // lowinventory

/**
 * _categoryTrend(int) -> String
 * 
 * This function will take in the category of a given item (leisure, school or office) the
 * return the number of items within that category as type string.
 */
  String _categoryTrend(int category) {
    int itemCateg = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].itemCategory == category) {
        itemCateg++;
      }
    }
    return itemCateg.toString();
  } //_categoryTrend

  /**
   * _getItems() ->Void
   * 
   * This function will be exuted at the very begining of our program. 
   * It will fetch all the lists from our database, assign them to our
   * local list "items" so we can access them within our meethods.
   * 
   */
  void _getItems() {
    APIService.fetchInventory().then((response) {
      Iterable list = json.decode(response.body);
      List<Item> itemList;
      itemList = list.map((model) => Item.fromObject(model)).toList();

      setState(() {
        items = itemList;
      });
    });
  } // getItems

} // end of class
