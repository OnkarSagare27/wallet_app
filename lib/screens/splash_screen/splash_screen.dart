import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/models/user_model.dart';
import 'package:wallet_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    loadData();
  }

  // This method checks if the user is already logged in and the navigate accordingly
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic data = prefs.getString('userData');

    await Future.delayed(const Duration(seconds: 3));

    if (data != null) {
      Map<String, dynamic> userData = jsonDecode(data);
      authProvider.userModel = UserModel.fromJson(userData);
      log(userData.toString());
      if (authProvider.userModel!.hasWallet) {
        Navigator.pushReplacementNamed(context, '/wallet_screen');
      } else {
        Navigator.pushReplacementNamed(context, '/create_wallet_screen');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
