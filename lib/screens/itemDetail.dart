/**
 * ItemDetail.dart
 * 
 * This class is calleed from the toolBox class (when the user presses any given item)
 * It inherits an input of type Item from the ToolBox class. After that, it goes
 * to display each characteristic of that input on the screen via a textformfield
 * 
 * It also displays teh total value of the item by taking the price * by the quantity. 
 * 
 * Potential Expansion:
 *  - since we have textformfield, we can easily update the values vy changing (if we have HttpPut implemented)
 *  - same idea, we can also perform the addition of new items and deleting of current items
 * 
 * Date Last Modified: January 29 2021
 */
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
/**
 * The following will build our main view for the itemdetail screen via Scaffold
 */
  @override
  Widget build(BuildContext context) {
    double totalPrice = item.itemPrice * item.itemQuantity;
    quantityController.text = item.itemQuantity.toString();
    priceController.text = "\$ " + item.itemPrice.toString();
    totalController.text = "\$ " + totalPrice.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.itemName, // display the name of the item on the appbar
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

  /**
   * _buildItemDetails() --> Widget (padding)
   * 
   * Most of our UI will be build from here (which then this function will be called in our main widget)
   * This function displays a listview in which it has the 3 items (quantity, price and total value). It 
   * calls the _buildTextBox function that will build those specific elemetns
   */
  Widget _buildItemDetails() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView(children: <Widget>[
        _buildTextBox("Quantity", quantityController),
        SizedBox(height: 50),
        _buildTextBox("Price", priceController),
        SizedBox(height: 50),
        _buildTextBox("Total Value", totalController),
      ]),
    );
  }

/**
 * _buildTextBox(String, TextEditingController) -> TextFormField
 * 
 * Given a string (for the label) and the controllerItem(for the information to display),
 * this function will build a textform box for those items with the the specific information.
 * It is important that this textbox only reads the value (meaning you cannot type in new values).
 * As noted in the header of this class, this can be changed for further expansion of this class
 * 
 */
  Widget _buildTextBox(String label, TextEditingController controllerItem) {
    return TextFormField(
      readOnly: true, // blocks editing
      controller: controllerItem,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 50),
          )),
    );
  }
}
