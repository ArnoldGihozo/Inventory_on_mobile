import 'dart:convert';
import 'package:http/http.dart' as http;


class APIService{

  static String inventoryAPIUrl = 'https://inventoryonmobile.azurewebsites.net/api/inventory';

  static Future fetchInventory() async{
    return await http.get(inventoryAPIUrl);
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // need to add delete and post



}