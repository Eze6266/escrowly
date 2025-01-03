import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/endpoint_urls.dart';

class OrderProvider extends ChangeNotifier {
  //**********************FETCH INCOMING ORDER*****************//
  bool fetchIncomingOrderisLoading = false;
  var fetchIncomingOrderStatus;
  var fetchIncomingOrderMessage;

  List incomingOrders = [];

  Future<String?> fetchIncomingOrder({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    fetchIncomingOrderisLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.fetchIncomingOrder}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is fetch incoming orders ${response.statusCode}');

      fetchIncomingOrderisLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        fetchIncomingOrderStatus =
            jsonDecode(responseString)['status'].toString();
        incomingOrders = jsonDecode(responseString)['data'];

        notifyListeners();

        return fetchIncomingOrderStatus;
      } else {
        String responseString = response.body;
        fetchIncomingOrderStatus =
            jsonDecode(responseString)['status'].toString();
        fetchIncomingOrderMessage = jsonDecode(responseString)['statusMessage'];
        notifyListeners();
        return fetchIncomingOrderStatus;
      }
    } catch (error) {
      fetchIncomingOrderisLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return fetchIncomingOrderStatus;
  }

///////////////////**********************FETCH INCOMING ORDER*****************////////////////////
}
