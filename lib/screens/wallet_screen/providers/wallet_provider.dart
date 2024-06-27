import 'package:flutter/material.dart';
import 'package:wallet_app/services/api_services.dart';

// Wallet provider to handle state of Wallet screens
class WalletProvider extends ChangeNotifier {
  double _balance = 0.00;

  double get balance => _balance;

  set balance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  Future<void> getUserBalance(
      String walletAddress, String network, String token) async {
    Map<String, dynamic>? newBalRes =
        await ApiServices.getBalance(walletAddress, network, token);
    if (newBalRes != null) {
      _balance = double.parse(newBalRes['balance'].toString());
      notifyListeners();
    }
  }
}
