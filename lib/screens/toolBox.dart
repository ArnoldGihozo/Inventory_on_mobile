/*
ToolBox.dart

Description:
In this class, you will find the UI that outlines all the items that we have
in the database. The basic idea here is that we take a List<Items> fetch the
data from our API (in the api services class), and store it in that list.

From there, we can access each item's name, and quantity that we display
via a ListBuilder (that is build dynamically). If the user clicks
on the item, they are then taken to a an ItemDetail page that displays
the quanitty, unit price and total value. 

Implemetnation starts in the ToolBoxState class

Date Last Modified: January 29 2021
*/
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/itemDetail.dart';
import 'package:inventory_on_mobile/services/apiService.dart';
import 'package:inventory_on_mobile/services/item.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class ToolBox extends StatefulWidget {
  ToolBox({Key key}) : super(key: key);

  @override
  _ToolBoxState createState() => _ToolBoxState();
}

class _ToolBoxState extends State<ToolBox> {
  List<Item> items;

/**
 * The following will build our main view for the tool box screen via Scaffold
 */
  @override
  Widget build(BuildContext context) {
    _getItems(); // fetches items from db

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tool Box",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: items == null // this part is for when item are being fetched
          ? Center(
              child: Text('We are loading items in your pantry'),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildPantryItems(
                    index); // our items that are being returned as Cards from database
              },
            ),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

/**
 * _buildPantryItems(int) -> Widget (as a Card)
 * 
 * The following function will return a widget that will 
 * build all the items from your database. It will display
 * the items using a ListBuilder (and data will be displayed on Listile)
 * 
 * onTap --> will lead you the the itemDetail page of your specific clicked on item 
 */
  Widget _buildPantryItems(int index) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      child: ListTile(
        trailing: Icon(Icons.more),
        title: Text(
          items[index].itemName,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        subtitle: Text(
          "Quantity: " + items[index].itemQuantity.toString(),
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        leading: _iconByCategory(this.items[index].itemCategory),
        onTap: () {
          _goToItemDetail(this.items[index]);
        },
      ),
    );
  } // buildpantryItems

/**
 * _getItems() --> void
 * 
 * This function will take no input and return nothing. 
 * It will execute the background work of fetching items from the database
 * by calling the ApiService class (located in apiService.dart).
 * 
 * change state to allow our items feteched locally (via itemList) to be availalbe
 * in our entire class
 */
  void _getItems() {
    APIService.fetchInventory().then((response) {
      Iterable list = json.decode(response.body); // transforming our json data
      List<Item> itemList;
      itemList = list.map((model) => Item.fromObject(model)).toList();
      setState(() {
        items = itemList;
      });
    });
  } // _getItems()

  /**
   * _goToItemDetail (Item) --> void
   * 
   * This function will take an a variable of Item type and send it to the ItemDetail() to display 
   * all the characteristics of that item. 
   */
  void _goToItemDetail(Item item) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemDetail(item)));
  }

/**
 * _iconByCategory (Int) --> 
 * 
 * This function will take as input an Intger (which represetns a given category) and displays the
 * appropriate icon within the listbuilder
 * 
 * Here is how the integers are set-up in the database:
 * leisure = 1
 * office =  2
 * school =  3
 * 
 */
  Widget _iconByCategory(int category) {
    var leisure = Icon(
      Icons.format_paint,
      color: Colors.red,
    );
    var office = Icon(
      Icons.work,
      color: Colors.black,
    );
    var school = Icon(Icons.school);
    var na = Icon(Icons.delete);

    return category == 1
        ? leisure
        : category == 2
            ? office
            : category == 3
                ? school
                : na;
  }
} // end of toolBox
