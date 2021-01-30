/**
 * APIService.dart
 * 
 * This class is our main connection between our API and application.
 * It contains our url to our Web API. When connecting, it to our Back-End
 * system (through Visual Studio using ASP.NET and C#) it executes an
 * HTTPGET request to our database (MongoDB).
 * 
 * 
 * Potential Expansion:
 *  - If HTTPPOst/ HTTPPUT and HTTPDelete requests are impleented in our back-end system, then 
 *    those services can be added on this class so they can connect with our UI.
 * 
 * Date Last Modified: January 29 2021
 */

import 'package:http/http.dart' as http;

class APIService {
  static String inventoryAPIUrl =
      'https://inventoryonmobile.azurewebsites.net/api/inventory';

/**
 * fetchInventory() --> Future
 * 
 * This function will access our API and fetch all our JSON data coming from it.
 * If there is a failuture to connect, no response will be given and error message
 * will be displayed at the given screen (check screen section for that).
 */
  static Future fetchInventory() async {
    try {
      final response = await http.get(inventoryAPIUrl);
      if (response.statusCode == 200) return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  } // fetchInventory

}
