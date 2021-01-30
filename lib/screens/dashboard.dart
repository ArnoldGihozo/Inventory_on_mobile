import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/services/apiService.dart';
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

  @override
  @override
  Widget build(BuildContext context) {
    getItems();

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
      body: items == null
          ? Center(
              child: Text('Loading your pantry ...'),
            )
          : SafeArea(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                paddingText("Welcome!"),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20.0,
                      children: <Widget>[
                        bigTextBox("Attention", lowInventory(items.length),
                            " item(s) in stock", Colors.yellow[800]),
                        bigTextBox("In Stock", items.length.toString(),
                            " item(s)", Colors.black),
                        paddingText("Your Current Trends"),
                        SizedBox(height: 10),
                        _smallTextBox("Leisure", categoryTrend(1), Colors.red),
                        _smallTextBox("School", categoryTrend(3), Colors.blue),
                        _smallTextBox("Office", categoryTrend(2), Colors.black)
                      ],
                    ),
                  ),
                )
              ],
            )),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

  Widget _buildDashboard() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Welcome, Doctor code \nSelect an option",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  void getItems() {
    APIService.fetchInventory().then((response) {
      Iterable list = json.decode(response.body);
      List<Item> itemList;
      itemList = list.map((model) => Item.fromObject(model)).toList();

      setState(() {
        items = itemList;
      });
    });
  }

  Widget paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget bigTextBox(String titleText, String numberText, String trailingText, Color colorBackground) {
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
  }

  Widget _smallTextBox(String textBoxTitle, String numItemCat, Color colorBackground) {
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

  String lowInventory(int length) {
    int counter = 0;

    for (int i = 0; i < length; i++) {
      if (items[i].itemQuantity < 2) {
        counter++;
      }
    }
    setState(() {
      low = counter.toString();
    });
    return counter.toString();
  }

  String categoryTrend(int category) {
    int itemCateg = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].itemCategory == category) {
        itemCateg++;
      }
    }
    return itemCateg.toString();
  }
} // end of class
