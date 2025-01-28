import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustbridge/Controllers/endpoint_urls.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';

class AuthProvider extends ChangeNotifier {
  /////////////////////**********************SEND OTP************//////////////////

  bool senOtpIsLoading = false;
  var senOtpStatus, senOtpMessage;

  Future<String?> senOtp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    senOtpIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.sendOtp}'),
        body: {
          "email": email,
          "password": password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is send otp status code ${response.statusCode}');

      senOtpIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        senOtpStatus = jsonDecode(responseString)['status'].toString();
        senOtpMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return senOtpStatus;
      } else {
        String responseString = response.body;
        senOtpStatus = jsonDecode(responseString)['status'].toString();
        senOtpMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return senOtpStatus;
      }
    } catch (error) {
      senOtpIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return senOtpStatus;
  }

/////////////////////**********************SEND OTP************//////////////////

  /////////////////////**********************REGISTER USER************//////////////////

  bool registerUserIsLoading = false;
  var registerUserStatus, registerUserMessage;

  Future<String?> registerUser({
    required String email,
    required String otp,
    required String phone,
    required String firstName,
    required String nin,
    required String lastName,
    required BuildContext context,
  }) async {
    registerUserIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.registerUser}'),
        body: {
          "otp": otp,
          "email": email,
          "username": firstName,
          "phone": phone,
          "firstname": firstName,
          "lastname": lastName,
          "nin": nin,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is register user status code ${response.statusCode}');

      registerUserIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        registerUserStatus = jsonDecode(responseString)['status'].toString();
        registerUserMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return registerUserStatus;
      } else {
        String responseString = response.body;
        registerUserStatus = jsonDecode(responseString)['status'].toString();
        registerUserMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return registerUserStatus;
      }
    } catch (error) {
      registerUserIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return registerUserStatus;
  }

/////////////////////**********************REGISTER USER************//////////////////

  /////////////////////**********************VERIFY OTP************//////////////////

  bool verifyOtpIsLoading = false;
  var verifyOtpStatus, verifyOtpMessage;

  Future<String?> verifyOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    verifyOtpIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.verifyOtp}'),
        body: {
          "otp": otp,
          "email": email,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is verify otp status code ${response.statusCode}');

      verifyOtpIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        verifyOtpStatus = jsonDecode(responseString)['status'].toString();
        verifyOtpMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return verifyOtpStatus;
      } else {
        String responseString = response.body;
        verifyOtpStatus = jsonDecode(responseString)['status'].toString();
        verifyOtpMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return verifyOtpStatus;
      }
    } catch (error) {
      verifyOtpIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return verifyOtpStatus;
  }

/////////////////////**********************VERIFY OTP************//////////////////

  /////////////////////**********************LOGIN USER************//////////////////

  bool loginUserIsLoading = false;
  var loginUserStatus, loginUserMessage;
  var authToken = '';

  Future<String?> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginUserIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.loginUser}'),
        body: {
          "email": email,
          "password": password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is login status code ${response.statusCode}');

      loginUserIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        loginUserStatus = jsonDecode(responseString)['status'].toString();
        loginUserMessage = jsonDecode(responseString)['message'];
        authToken = jsonDecode(responseString)['token'].toString();
        pref.setString('token', authToken);

        notifyListeners();

        return loginUserStatus;
      } else {
        String responseString = response.body;
        loginUserStatus = jsonDecode(responseString)['status'].toString();
        loginUserMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return loginUserStatus;
      }
    } catch (error) {
      loginUserIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return loginUserStatus;
  }

/////////////////////**********************LOGIN USER************//////////////////

  /////////////////////**********************SEND PASSWORD OTP************//////////////////

  bool sendPwdOtpIsLoading = false;
  var sendPwdOtpStatus, sendPwdOtpMessage;

  Future<String?> sendPwdOtp({
    required String email,
    required BuildContext context,
  }) async {
    sendPwdOtpIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.sendForgotpwdotp}'),
        body: {
          "email": email,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is send password otp status code ${response.statusCode}');

      sendPwdOtpIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        sendPwdOtpStatus = jsonDecode(responseString)['status'].toString();
        sendPwdOtpMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return sendPwdOtpStatus;
      } else {
        String responseString = response.body;
        sendPwdOtpStatus = jsonDecode(responseString)['status'].toString();
        sendPwdOtpMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return sendPwdOtpStatus;
      }
    } catch (error) {
      sendPwdOtpIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return sendPwdOtpStatus;
  }

/////////////////////**********************SEND PASSWORD OTP************//////////////////

  /////////////////////**********************RESET PASSWORD************//////////////////

  bool resetPwdIsLoading = false;
  var resetPwdStatus, resetPwdMessage;

  Future<String?> resetPwd({
    required String email,
    required String password,
    required String otp,
    required BuildContext context,
  }) async {
    resetPwdIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.resetPwd}'),
        body: {
          "email": email,
          "otp": otp,
          "password": password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is reset password status code ${response.statusCode}');

      resetPwdIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        resetPwdStatus = jsonDecode(responseString)['status'].toString();
        resetPwdMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return resetPwdStatus;
      } else {
        String responseString = response.body;
        resetPwdStatus = jsonDecode(responseString)['status'].toString();
        resetPwdMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return resetPwdStatus;
      }
    } catch (error) {
      resetPwdIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return resetPwdStatus;
  }

/////////////////////**********************RESET PASSWORD************//////////////////

  //**********************GET USER*****************//
  bool getUserisLoading = false;
  var getUserStatus;
  var getUserMessage;

  var email, firstName, lastName, phone, userID, userName, escrowTag;
  bool hasPin = false;
  bool phoneVerified = false;

  Future<String?> getUser({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    getUserisLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.getUser}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is get user ${response.statusCode}');

      getUserisLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        getUserStatus = jsonDecode(responseString)['status'].toString();
        authToken =
            jsonDecode(responseString)['data']['access_token'].toString();
        email = jsonDecode(responseString)['data']['email'].toString();

        firstName = jsonDecode(responseString)['data']['first_name'].toString();
        userID = jsonDecode(responseString)['data']['id'].toString();
        lastName = jsonDecode(responseString)['data']['last_name'].toString();
        userName = jsonDecode(responseString)['data']['username'].toString();
        phone = jsonDecode(responseString)['data']['phone'].toString();
        escrowTag = jsonDecode(responseString)['data']['trust_tag'].toString();
        hasPin = jsonDecode(responseString)['data']['has_pin'];
        phoneVerified = jsonDecode(responseString)['data']['number_verified'];

        notifyListeners();

        return getUserStatus;
      } else {
        String responseString = response.body;
        getUserStatus = jsonDecode(responseString)['status'].toString();
        getUserMessage = jsonDecode(responseString)['statusMessage'];
        notifyListeners();
        return getUserStatus;
      }
    } catch (error) {
      getUserisLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return getUserStatus;
  }

///////////////////**********************GET USER*****************////////////////////

  //***************************** VERIFY NIN ****************************//

  var verifyNinMessage;

  var verifyNinStatus;
  bool verifyNinisLoading = false;
  Future<String?> verifyNIN(
    String nin,
    String token,
  ) async {
    print('dddddddddddddddddddddddddddddddddddddddddddddd $token');
    try {
      verifyNinisLoading = true;

      notifyListeners();
      var response = await http.post(
        Uri.parse('${kUrl.verifyNin}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "nin": nin,
        }),
      );
      verifyNinisLoading = false;
      notifyListeners();
      print('this is the verify nin response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (jsonDecode(data)['requestSuccessful'].toString() == 'true') {
        verifyNinStatus = 'success';

        notifyListeners();
        return verifyNinStatus;
      } else {
        verifyNinStatus = 'error';
        verifyNinMessage = jsonDecode(data)['responseMessage'];
        notifyListeners();
        return verifyNinStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }
  //***************************** VERIFY NIN ****************************//

  //***************************** GET TOKEN ****************************//

  var getToken;
  bool getTokenisLoading = false;
  var getTokenStatus;
  var getTokenMessage;

  Future<String?> generateToken() async {
    try {
      getTokenisLoading = true;
      notifyListeners();
      // var apiKey = '${subzApiKey}';
      // var secretKey = '${subzSecretKey}';
      var credentials = base64.encode(
        utf8.encode('${kUrl.monnyKey}:${kUrl.secret}'),
      );

      notifyListeners();
      var response = await http.post(
        Uri.parse('${kUrl.monnifyBase}/api/v1/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $credentials',
        },
      );
      getTokenisLoading = false;
      notifyListeners();
      print('this is the getToken response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        getToken = jsonDecode(data)['responseBody']['accessToken'].toString();
        getTokenStatus = jsonDecode(data)['requestSuccessful'].toString();

        notifyListeners();
        return getTokenStatus;
      } else {
        getTokenMessage = jsonDecode(data)['responseMessage'];
        getTokenStatus = jsonDecode(data)['requestSuccessful'].toString();

        notifyListeners();
        return getTokenStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }
  //***************************** GET TOKEN ****************************//

  //**********************GET NOTIFICATIONS*****************//
  bool getNotifcationsisLoading = false;
  var getNotifcationsStatus;
  var getNotifcationsMessage;

  List notifcations = [];

  Future<String?> getNotifcations({
    required BuildContext context,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    getNotifcationsisLoading = true;
    notifyListeners();
    var token = pref.getString('token');
    print('$token');
    try {
      var response = await http.get(
        Uri.parse('${kUrl.getNotifcations}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('this is get notifcations ${response.statusCode}');

      getNotifcationsisLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        getNotifcationsStatus = jsonDecode(responseString)['status'].toString();
        notifcations = jsonDecode(responseString)['data'];

        notifyListeners();

        return getNotifcationsStatus;
      } else {
        String responseString = response.body;
        getNotifcationsStatus = jsonDecode(responseString)['status'].toString();
        getNotifcationsMessage = jsonDecode(responseString)['statusMessage'];
        notifyListeners();
        return getNotifcationsStatus;
      }
    } catch (error) {
      getNotifcationsisLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return getNotifcationsStatus;
  }

///////////////////**********************GET NOTIFICATIONS*****************////////////////////

  /////////////////////**********************READ NOTIFICATION************//////////////////

  bool readNotificationIsLoading = false;
  var readNotificationStatus, readNotificationMessage;

  Future<String?> readNotification({
    required String id,
    required BuildContext context,
  }) async {
    readNotificationIsLoading = true;
    notifyListeners();

    try {
      var response = await http.patch(
        Uri.parse('${kUrl.readNotification}/$id/read'),
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is read notification status code ${response.statusCode}');

      readNotificationIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        readNotificationStatus =
            jsonDecode(responseString)['status'].toString();
        readNotificationMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return readNotificationStatus;
      } else {
        String responseString = response.body;
        readNotificationStatus =
            jsonDecode(responseString)['status'].toString();
        readNotificationMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return readNotificationStatus;
      }
    } catch (error) {
      readNotificationIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return readNotificationStatus;
  }

/////////////////////**********************READ NOTIFICATION************//////////////////

  /////////////////////**********************CHANGE PASSWORD************//////////////////

  bool changePwdIsLoading = false;
  var changePwdStatus, changePwdMessage;

  Future<String?> changePwd({
    required String oldPwd,
    required String newPwd,
    required BuildContext context,
  }) async {
    changePwdIsLoading = true;
    notifyListeners();

    try {
      var response = await http.post(
        Uri.parse('${kUrl.changePwd}'),
        body: {
          "oldpassword": oldPwd,
          "password": newPwd,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      print('this is change password status code ${response.statusCode}');

      changePwdIsLoading = false;
      notifyListeners();
      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseString = response.body;
        changePwdStatus = jsonDecode(responseString)['status'].toString();
        changePwdMessage = jsonDecode(responseString)['message'];

        notifyListeners();

        return changePwdStatus;
      } else {
        String responseString = response.body;
        changePwdStatus = jsonDecode(responseString)['status'].toString();
        changePwdMessage = jsonDecode(responseString)['message'];
        notifyListeners();
        return changePwdStatus;
      }
    } catch (error) {
      changePwdIsLoading = false;
      notifyListeners();
      ErrorHandler.handleError(error, context);
      print(error);
    }
    notifyListeners();
    return changePwdStatus;
  }

/////////////////////**********************CHANGE PASSWORD************//////////////////
  void authNotifier() {
    notifyListeners();
  }
}

class ErrorHandler {
  static void handleError(dynamic error, BuildContext context) {
    if (error is TimeoutException) {
      return showCustomErrorToast(
          context, 'Request timeout. Please try again later.');
    } else if (error is SocketException) {
      return showCustomErrorToast(context,
          'Network connection failed. Please check your internet and try again.');
    } else {
      return showCustomErrorToast(
          context, 'An error occurred. Failed to connect.');
    }
  }
}
