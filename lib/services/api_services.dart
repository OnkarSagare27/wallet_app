import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallet_app/core/endpoints.dart';

import '../models/user_model.dart';

class ApiServices {
  static Future<UserModel?> login(String mixed, String password) async {
    String url = Endpoints.baseUrl + Endpoints.login;
    try {
      final Map<String, dynamic> body = {"mixed": mixed, "password": password};
      // const Map<String, String> headers = {"Content-Type": "application/json"};
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
}
