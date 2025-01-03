import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/endpoint_urls.dart';

class TransactionProvider extends ChangeNotifier {
/////////////////////**********************FETCH ACCOUNT NUMBERS************//////////////////

  bool fetchAccNumbersIsLoading = false;
  var fetchAccNumbersStatus, fetchAccNumbersMessage;
  List accNumbers = [];

  Future<String?> fetchAccNumbers({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    fetchAccNumbersIsLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.fetchAccNumbers}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is get account numbers status code ${response.statusCode}');

      fetchAccNumbersIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        fetchAccNumbersStatus = jsonDecode(responseString)['status'].toString();
        fetchAccNumbersMessage = jsonDecode(responseString)['message'];
        accNumbers = jsonDecode(responseString)['data'];

        notifyListeners();

        return fetchAccNumbersStatus;
      } else {
        String responseString = response.body;
        fetchAccNumbersStatus = jsonDecode(responseString)['status'].toString();
        fetchAccNumbersMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return fetchAccNumbersStatus;
      }
    } catch (error) {
      fetchAccNumbersIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return fetchAccNumbersStatus;
  }

/////////////////////**********************FETCH ACCOUNT NUMBERS************//////////////////

/////////////////////**********************FETCH BALANCES************//////////////////

  bool fetchBalancesIsLoading = false;
  var fetchBalancesStatus, fetchBalancesMessage, walletBalance, payoutBalance;

  Future<String?> fetchBalances({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    fetchBalancesIsLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.fetchBalances}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is get account balances status code ${response.statusCode}');

      fetchBalancesIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        fetchBalancesStatus = jsonDecode(responseString)['status'].toString();
        fetchBalancesMessage = jsonDecode(responseString)['message'];
        walletBalance = jsonDecode(responseString)['mainbalance'].toString();
        payoutBalance = jsonDecode(responseString)['payoutbalance'].toString();

        notifyListeners();

        return fetchBalancesStatus;
      } else {
        String responseString = response.body;
        fetchBalancesStatus = jsonDecode(responseString)['status'].toString();
        fetchBalancesMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return fetchBalancesStatus;
      }
    } catch (error) {
      fetchBalancesIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return fetchBalancesStatus;
  }

/////////////////////**********************FETCH BALANCES************//////////////////

/////////////////////**********************FETCH BANK LIST************//////////////////

  bool fetchBankListIsLoading = false;
  var fetchBankListStatus, fetchBankListMessage;
  List banks = [];
  var selectedBank = '';
  var selectedCode = '';

  Future<String?> fetchBankList({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    fetchBankListIsLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.fetchBankList}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is get fetch bank list status code ${response.statusCode}');

      fetchBankListIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        fetchBankListStatus = jsonDecode(responseString)['status'].toString();
        fetchBankListMessage = jsonDecode(responseString)['message'];
        banks = jsonDecode(responseString)['banks'];

        notifyListeners();

        return fetchBankListStatus;
      } else {
        String responseString = response.body;
        fetchBankListStatus = jsonDecode(responseString)['status'].toString();
        fetchBankListMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return fetchBankListStatus;
      }
    } catch (error) {
      fetchBankListIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return fetchBankListStatus;
  }

/////////////////////**********************FETCH BANK LIST************//////////////////

  /////////////////////**********************VALIDATE ACCOUNT NAME************//////////////////

  bool validateAccNameIsLoading = false;
  var validateAccNameStatus, validateAccNameMessage;
  var accName = '';

  Future<String?> validateAccName({
    required String accNumber,
    required String bankCode,
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    accName = '';
    validateAccNameIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.validateAccName}'),
        headers: {
          'Acccept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "accountnumber": accNumber,
          "bank": bankCode,
        },
      );
      print('this is validate account name status code ${response.statusCode}');

      validateAccNameIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;

        validateAccNameStatus = jsonDecode(responseString)['status'].toString();
        validateAccNameMessage =
            jsonDecode(responseString)['message'].toString();
        accName = jsonDecode(responseString)['data']['bank']['name'].toString();

        notifyListeners();

        return validateAccNameStatus;
      } else {
        String responseString = response.body;
        validateAccNameStatus = 'false';

        validateAccNameMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return validateAccNameStatus;
      }
    } catch (error) {
      validateAccNameIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return validateAccNameStatus;
  }

/////////////////////**********************VALIDATE ACCOUNT NAME************//////////////////
  void trxnNotifier() {
    notifyListeners();
  }
}
