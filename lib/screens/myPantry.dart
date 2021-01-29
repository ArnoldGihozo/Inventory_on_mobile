import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/screens/dashboard.dart';
import 'package:inventory_on_mobile/services/apiService.dart';
import 'package:inventory_on_mobile/services/item.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class MyPantry extends StatefulWidget {
  MyPantry({Key key}) : super(key: key);

  @override
  _MyPantryState createState() => _MyPantryState();
}

class _MyPantryState extends State<MyPantry> {
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    getItems();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantry"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: items == null
          ? Center(
              child: Text('There is nothing in your pantry'),
            )
          : _buildPantryItems(),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

  Widget _buildPantryItems() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
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
            leading: iconByCategory(this.items[index].itemCategory),
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

  Widget iconByCategory(int category) {
    var fruits = Icon(Icons.food_bank_rounded, color: Colors.red,);
    var meals = Icon(Icons.access_alarm_outlined, color: Colors.blue,);
    var vegetables = Icon(Icons.access_alarm);
    var na = Icon(Icons.delete);

    return category==1? fruits : category ==2? meals : na;
  }
}
