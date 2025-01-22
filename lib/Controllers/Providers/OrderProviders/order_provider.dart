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

  /////////////////////**********************ACCEPT ORDER************//////////////////

  bool acceptOrderIsLoading = false;
  var acceptOrderStatus, acceptOrderMessage;

  Future<String?> acceptOrder({
    required String orderid,
    required BuildContext context,
  }) async {
    acceptOrderIsLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');

    notifyListeners();
    print('ajeeeeee $orderid');
    try {
      var response = await http.post(
        Uri.parse('${kUrl.acceptOrder}'),
        body: {
          "ID": orderid,
          "pin": '1234',
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is accept order status code ${response.statusCode}');

      acceptOrderIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        acceptOrderStatus = jsonDecode(responseString)['status'].toString();
        acceptOrderMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return acceptOrderStatus;
      } else {
        String responseString = response.body;
        acceptOrderStatus = jsonDecode(responseString)['status'].toString();
        acceptOrderMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return acceptOrderStatus;
      }
    } catch (error) {
      acceptOrderIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return acceptOrderStatus;
  }

/////////////////////**********************ACCEPT ORDER************//////////////////

  /////////////////////**********************REJECT ORDER************//////////////////

  bool rejectOrderIsLoading = false;
  var rejectOrderStatus, rejectOrderMessage;

  Future<String?> rejectOrder({
    required String orderid,
    required BuildContext context,
  }) async {
    rejectOrderIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.rejectOrder}'),
        body: {
          "ID": orderid,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is reject order status code ${response.statusCode}');

      rejectOrderIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        rejectOrderStatus = jsonDecode(responseString)['status'].toString();
        rejectOrderMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return rejectOrderStatus;
      } else {
        String responseString = response.body;
        rejectOrderStatus = jsonDecode(responseString)['status'].toString();
        rejectOrderMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return rejectOrderStatus;
      }
    } catch (error) {
      rejectOrderIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return rejectOrderStatus;
  }

/////////////////////**********************REJECT ORDER************//////////////////

  //**********************FETCH TRANSACTIONS*****************//
  bool fetchTrxnsisLoading = false;
  var fetchTrxnsStatus;
  var fetchTrxnsMessage;

  List trns = [];
  List runningOrders = [];

  Future<String?> fetchTrxns({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    fetchTrxnsisLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.fetchTrxns}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is fetch trxns ${response.statusCode}');

      fetchTrxnsisLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        fetchTrxnsStatus = 'success';
        trns = jsonDecode(responseString);

        // Filter and populate runningOrders list
        runningOrders = trns.where((item) => item['status'] == "2").toList();

        notifyListeners();
        return fetchTrxnsStatus;
      } else {
        String responseString = response.body;
        fetchTrxnsStatus = jsonDecode(responseString)['status'].toString();
        fetchTrxnsMessage = jsonDecode(responseString)['statusMessage'];
        notifyListeners();
        return fetchTrxnsStatus;
      }
    } catch (error) {
      fetchTrxnsisLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return fetchTrxnsStatus;
  }

///////////////////**********************FETCH TRANSACTIONS*****************////////////////////

  /////////////////////**********************CREATE BUYER ORDER************//////////////////

  bool createBuyerOrderIsLoading = false;
  var createBuyerOrderStatus, createBuyerOrderMessage;

  Future<String?> createBuyerOrder({
    required String email,
    required String phone,
    required String description,
    required String amount,
    required String payer,
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    createBuyerOrderIsLoading = true;
    notifyListeners();
    var token = pref.getString('token');

    var payload = {
      "buyerEmail": '',
      "sellerEmail": email,
      "buyerPhone": '',
      "sellerPhone": phone,
      "delivery_date": DateTime.now().toString(),
      "description": description,
      "total_amount": amount,
      "delivery_address": "Non",
      "role": "Buying",
      "escrow_fee_payer": payer,
    };
    print(payload);
    try {
      var response = await http.post(
        Uri.parse('${kUrl.createOrder}'),
        body: payload,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is create buyer order status code ${response.statusCode}');

      createBuyerOrderIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        createBuyerOrderStatus =
            jsonDecode(responseString)['status'].toString();
        createBuyerOrderMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return createBuyerOrderStatus;
      } else {
        String responseString = response.body;
        createBuyerOrderStatus =
            jsonDecode(responseString)['status'].toString();
        createBuyerOrderMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return createBuyerOrderStatus;
      }
    } catch (error) {
      createBuyerOrderIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return createBuyerOrderStatus;
  }

/////////////////////**********************CREATE BUYER ORDER************//////////////////

  /////////////////////**********************CREATE SELLER ORDER************//////////////////

  bool createSellerOrderIsLoading = false;
  var createSellerOrderStatus, createSellerOrderMessage;

  Future<String?> createSellerOrder({
    required String email,
    required String phone,
    required String description,
    required String amount,
    required String payer,
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    createSellerOrderIsLoading = true;
    notifyListeners();
    var token = pref.getString('token');

    var payload = {
      "buyerEmail": email,
      "sellerEmail": '',
      "buyerPhone": phone,
      "sellerPhone": '',
      "delivery_date": DateTime.now().toString(),
      "description": description,
      "total_amount": amount,
      "delivery_address": "Non",
      "role": "Selling",
      "escrow_fee_payer": payer,
    };
    print(payload);
    try {
      var response = await http.post(
        Uri.parse('${kUrl.createOrder}'),
        body: payload,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is create seller order status code ${response.statusCode}');

      createSellerOrderIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        createSellerOrderStatus =
            jsonDecode(responseString)['status'].toString();
        createSellerOrderMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return createSellerOrderStatus;
      } else {
        String responseString = response.body;
        createSellerOrderStatus =
            jsonDecode(responseString)['status'].toString();
        createSellerOrderMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return createSellerOrderStatus;
      }
    } catch (error) {
      createSellerOrderIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return createSellerOrderStatus;
  }

/////////////////////**********************CREATE SELLER ORDER************//////////////////
}
