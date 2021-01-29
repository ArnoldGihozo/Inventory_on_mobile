class Item{
  String _itemName;
  int _itemCategory;
  int _itemQuantity;
  double _itemUnitPrice;

  // constructor
  Item(this._itemName, this._itemCategory, this._itemQuantity, this._itemUnitPrice);

  // getters
  String get itemName => _itemName;
  int get itemCategory => _itemCategory;
  int get itemQuantity => _itemQuantity;
  double get itemPrice => _itemUnitPrice;

  // our setters

set itemName (String newItemName){
  _itemName = newItemName;
}

set itemCategory (int newItemCategory){
  _itemCategory = newItemCategory;
}

set itemQuantity (int newItemQuantity){
  _itemQuantity = newItemQuantity;
}

set itemPrice (double newItemPrice){
  _itemUnitPrice = newItemPrice;
}

// mapping data to json (serialize)

Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  map["itemName"] = _itemName;
  map["itemCategory"] = _itemCategory;
  map["itemUnitPrice"] = _itemUnitPrice;
  map["itemQuantity"] = _itemQuantity;

  // if( _id != null){
  //   map["id"] = _id;
  // }

  return map;
}

Item.fromObject(dynamic object){
  this._itemName = object["itemName"];
  this._itemCategory = object["itemCategory"];
  this._itemUnitPrice = object["itemUnitPrice"];
  this.itemQuantity = object["itemQuantity"];
}

  
}