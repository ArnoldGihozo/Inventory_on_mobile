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
  var inStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getItems();
    // if(items == null){
    //   inStockController.text =  " 0 items";
    // }
    // //inStockController.text = items.length.toString() + " items";

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
              child: Text('There is nothing in your pantry'),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20.0,
                      children: <Widget>[
                        SizedBox(
                          width: 1000.0,
                          height: 135.0,
                          child: Card(
                            color: Colors.yellow[800],
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Attention",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "5 items are low on stock",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 1000.0,
                          height: 135.0,
                          child: Card(
                            color: Colors.black,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "In Stock",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    items.length.toString() + " items",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "      Your Current Trends",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 120.0,
                          height: 110.0,
                          child: Card(
                            color: Colors.red,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  //Image.asset("assets/note.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Leisure",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "12 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 110.0,
                          height: 110.0,
                          child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  //Image.asset("assets/note.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Sports",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "12 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                         SizedBox(
                          width: 120.0,
                          height: 110.0,
                          child: Card(
                            color: Colors.black,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  //Image.asset("assets/note.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Office",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "12 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
   
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

  getItems() {
    APIService.fetchInventory().then((response) {
      Iterable list = json.decode(response.body);

      // ignore: deprecated_member_use
      List<Item> itemList = List<Item>();
      itemList = list.map((model) => Item.fromObject(model)).toList();

      setState(() {
        items = itemList;
      });
    });
  }
} // end of class
