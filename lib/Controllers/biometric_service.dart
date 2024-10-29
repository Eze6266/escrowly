// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService extends ChangeNotifier {
  final LocalAuthentication auth = LocalAuthentication();
  bool isBiometricSupported = false;

  Future<void> initialize() async {
    try {
      isBiometricSupported = await auth.isDeviceSupported().then((value) {
        if (value) {
          isBiometricSupported = true;
          notifyListeners();
          return isBiometricSupported;
        } else {
          isBiometricSupported = false;
          notifyListeners();
          return isBiometricSupported;
        }
      });
      print('is biometric supported : $isBiometricSupported');
      notifyListeners();
    } on PlatformException catch (e) {
      print("Error checking device support: $e");
      isBiometricSupported = false;
      notifyListeners();
    }
  }

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: "Authenticate with fingerprint or Face ID",
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print("Authentication error: $e");
      notifyListeners();

      return false;
    }
  }
}
