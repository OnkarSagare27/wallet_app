import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/models/user_model.dart';
import 'package:wallet_app/services/api_services.dart';

import '../core/utils/connectivity_handler.dart';

class AuthProvider extends ChangeNotifier {
  // This bool handles the connectivity state of the application
  bool isConnected = true;

  AuthProvider() {
    // This listener listens to the network
    ConnectivityHandler.instance.onConnectivityChanged.listen((result) {
      isConnected = !result.contains(ConnectivityResult.none);
      notifyListeners();
    });
  }

  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  set userModel(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  // A methoud to login the user using login credentials and save the user data unto shared preferences
  Future<void> loginUser(String mixed, String password) async {
    _userModel = await ApiServices.login(mixed, password);
    if (_userModel != null) {
      SharedPreferences preffs = await SharedPreferences.getInstance();
      preffs.setString('userData', jsonEncode(_userModel!.toJson()));
    }
    notifyListeners();
  }
}
