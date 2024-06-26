import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallet_app/core/endpoints.dart';
import 'package:wallet_app/models/wallet_model.dart';

import '../models/user_model.dart';

class ApiServices {
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

      if (response.statusCode == 201) {
        dynamic body = jsonDecode(response.body);

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
}
