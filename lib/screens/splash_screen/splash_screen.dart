import 'dart:convert';
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

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic data = prefs.getString('userData');

    await Future.delayed(const Duration(seconds: 3));

    if (data != null) {
      Map<String, dynamic> userData = jsonDecode(data);
      authProvider.userModel = UserModel.fromJson(userData);
      Navigator.pushReplacementNamed(context, '/home_screen');
    } else {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
