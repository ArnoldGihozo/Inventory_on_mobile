import 'package:flutter/material.dart';
import 'package:inventory_on_mobile/services/item.dart';
import 'package:inventory_on_mobile/services/myBottomNavBar.dart';

class ItemDetail extends StatefulWidget {
  final Item myItem;

  ItemDetail(this.myItem);
  @override
  _ItemDetailState createState() => _ItemDetailState(myItem);
}

class _ItemDetailState extends State<ItemDetail> {
  Item item;
  _ItemDetailState(this.item);
  var quantityController = TextEditingController();
  var priceController = TextEditingController();
  var totalController = TextEditingController();
  var categories = ["Sport", "Office", "Education"];
  final errorMessage = SnackBar(content: Text("404, Connection issues"));
  @override
  Widget build(BuildContext context) {
    double totalPrice = item.itemPrice * item.itemQuantity;
    quantityController.text = item.itemQuantity.toString();
    priceController.text = "\$ " + item.itemPrice.toString();
    totalController.text = "\$ " + totalPrice.toString();

 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.itemName,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: _buildItemDetails(),
      bottomNavigationBar: MyBottomNaBar(),
    );
  }

  Widget _buildItemDetails() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView(children: <Widget>[
        TextFormField(
          readOnly: true,
          controller: quantityController,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              labelText: "Quantity",
              labelStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 50),
              )),
        ),
        SizedBox(height: 50),

        TextFormField(
          readOnly: true,
          controller: priceController,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              labelText: "Price",
              labelStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 50),
              )),
        ),

     SizedBox(height: 50),
         TextFormField(
          readOnly: true,
          controller: totalController,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              labelText: "Total Value",
              labelStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 50),
              )),
        ),
      ]),
    );
  }
}
