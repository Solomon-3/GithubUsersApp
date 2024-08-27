import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  InternetProvider() {
    _checkInternetConnection();
  }

  void _checkInternetConnection() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }
}