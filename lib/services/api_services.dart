import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallet_app/core/endpoints.dart';
import 'package:wallet_app/models/wallet_model.dart';

import '../models/user_model.dart';

// All API calls are made through this class
class ApiServices {
  // Login user method to login in the user into the app
  static Future<UserModel?> login(String mixed, String password) async {
    String url = Endpoints.baseUrl + Endpoints.login;
    try {
      final Map<String, dynamic> body = {"mixed": mixed, "password": password};
      final Response response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        dynamic body = jsonDecode(response.body);
        log(response.body);
        switch (body['status']) {
          case 'success':
            return UserModel.fromJson(body);
          default:
            return null;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Create user wallet method to create a new wallet for a user
  static Future<WalletModel?> createWallet(
      String token, String walletName, String network, String pincode) async {
    String url = Endpoints.baseUrl + Endpoints.createWallet;
    try {
      final Map<String, dynamic> body = {
        "wallet_name": walletName,
        "network": network,
        "user_pin": pincode
      };
      log(body.toString());
      final Map<String, String> headers = {"Flic-Token": token};
      final Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      log(response.body.toString());
      if (response.statusCode == 201) {
        dynamic body = jsonDecode(response.body);
        log(body);
        switch (body['status']) {
          case 'success':
            return WalletModel.fromJson(body);
          default:
            return null;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

// Get user balance method to fetch the balance of the user
  static Future<Map<String, dynamic>?> getBalance(
      String walletAddress, String network, String token) async {
    final String url =
        '${Endpoints.baseUrl}${Endpoints.getWalletBallance}?network=$network&wallet_address=$walletAddress';
    final Map<String, String> headers = {"Flic-Token": token};
    try {
      final Response response =
          await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 201) {
        dynamic body = jsonDecode(response.body);
        switch (body['status']) {
          case 'success':
            return body;
          default:
            return null;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

// Method to transfer the balance from one user account to another
  static Future<Map<String, dynamic>?> transferBalance(
      String recipientAddress,
      String network,
      String senderAddress,
      double amount,
      String userPin,
      String token) async {
    const String url = Endpoints.baseUrl + Endpoints.transferWalletBalance;
    final Map<String, String> headers = {"Flic-Token": token};
    final Map<String, dynamic> body = {
      "recipient_address": recipientAddress,
      "network": network,
      "sender_address": senderAddress,
      "amount": amount.toString(),
      "user_pin": userPin
    };

    try {
      final Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      log(response.body.toString());

      dynamic resBody = jsonDecode(response.body);
      return resBody;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
