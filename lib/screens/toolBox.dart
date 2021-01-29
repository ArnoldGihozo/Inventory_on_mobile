import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/dashboard.dart';
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
  List<Item> filteredItems;

  @override
  Widget build(BuildContext context) {
    getItems();
    filteredItems = items;
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
      body: items == null
          ? Center(
              child: Text('There is nothing in your pantry'),
            )
          : Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "SEARCH BY ITEM NAME",
                  ),
                  onChanged: (string) {
                    setState(() {
                      // filteredItems = items
                      //       .where((i) => (i.itemName
                      //           .toLowerCase()
                      //           .contains(string.toLowerCase())))
                      //       .toList();
                      filteredItems = items
                          .where((element) => element.itemName == 'Scissors')
                          .toList();
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 3.0,
                        child: ListTile(
                          trailing: Icon(Icons.more),
                          title: Text(
                            filteredItems[index].itemName,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          subtitle: Text(
                            "Quantity: " +
                                filteredItems[index].itemQuantity.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          leading:
                              iconByCategory(this.items[index].itemCategory),
                          onTap: () {
                            goToItemDetail(this.items[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

  Widget _buildPantryItems() {
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 3.0,
          child: ListTile(
            trailing: Icon(Icons.more),
            title: Text(
              filteredItems[index].itemName,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            subtitle: Text(
              "Quantity: " + filteredItems[index].itemQuantity.toString(),
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            leading: iconByCategory(this.items[index].itemCategory),
            onTap: () {
              goToItemDetail(this.items[index]);
            },
          ),
        );
      },
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

  void goToItemDetail(Item item) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemDetail(item)));
  }

  Widget iconByCategory(int category) {
    var leisure = Icon(
      Icons.sports_basketball,
      color: Colors.red,
    );
    var office = Icon(
      Icons.work,
      color: Colors.black,
    );
    var education = Icon(Icons.access_alarm);
    var na = Icon(Icons.delete);

    return category == 1
        ? leisure
        : category == 2
            ? office
            : category == 3
                ? education
                : na;
  }
}
