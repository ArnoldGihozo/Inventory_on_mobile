/**
 * Item.dart
 * 
 * This class defines the data that we find within our database. It carries our getters (to get specific
 * item) and our setters. This class also deserialzie our data, meaning mapping our Data from JSOn format to the format
 * we have in Item class (IOW, we are simply tranforming our JSON data into their corresponding values
 * in this class in order to be used in the rest of this program)
 * 
 * Date Last Modified: January 29 2021
 */

class Item {
  String _itemName;
  int _itemCategory;
  int _itemQuantity;
  double _itemUnitPrice;

  // constructor
  Item(this._itemName, this._itemCategory, this._itemQuantity,
      this._itemUnitPrice);

  // getters
  String get itemName => _itemName;
  int get itemCategory => _itemCategory;
  int get itemQuantity => _itemQuantity;
  double get itemPrice => _itemUnitPrice;

  // our setters

  set itemName(String newItemName) {
    _itemName = newItemName;
  }

  set itemCategory(int newItemCategory) {
    _itemCategory = newItemCategory;
  }

  set itemQuantity(int newItemQuantity) {
    _itemQuantity = newItemQuantity;
  }

  set itemPrice(double newItemPrice) {
    _itemUnitPrice = newItemPrice;
  }

/**
 * This function will deserialize our data by taking data from jSON and assigning it to 
 * variables in this class 
 */
  Item.fromObject(dynamic object) {
    this._itemName = object["itemName"];
    this._itemCategory = object["itemCategory"];
    this._itemUnitPrice = object["itemUnitPrice"];
    this.itemQuantity = object["itemQuantity"];
  }
}
