import 'package:flutter/material.dart';
import 'package:wallet_app/services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  String _balance = '0.00';

  String get balance => _balance;

  set balance(String newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  Future<void> getUserBalance(
      String walletAddress, String network, String token) async {
    Map<String, dynamic>? newBalRes =
        await ApiServices.getBalance(walletAddress, network, token);
    if (newBalRes != null) {
      _balance = double.parse(newBalRes['balance'].toString()).toString();
      notifyListeners();
    }
  }
}
