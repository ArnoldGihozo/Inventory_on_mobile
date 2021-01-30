/**
 * 
 */

import 'dart:convert';
import 'package:http/http.dart' as http;


class APIService{

  static String inventoryAPIUrl = 'https://inventoryonmobile.azurewebsites.net/api/inventory';

  static Future fetchInventory() async{
    try{
      final response = await http.get(inventoryAPIUrl);
      if (response.statusCode == 200)
         return response;

    }catch (e){
      throw Exception(e.toString());

    }
   
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // need to add delete and post



}