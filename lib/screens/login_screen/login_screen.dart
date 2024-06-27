import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/widgets/custom_dilog_box.dart';
import 'package:wallet_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // This bool holds the state of password, if true the password will be obscure
  bool isObscured = true;

  // Made this fuction to toggle the state of password
  void toggleObscured() {
    if (mounted) {
      setState(() {
        isObscured = !isObscured;
      });
    }
  }

  // Text editing controller for Username and password
  TextEditingController usernameOrEmailEditingController =
      TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  // These varibales will be used to set or change error text of username and password text field
  String? usernameOrEmailErrorText;
  String? passwordErrorText;

  // This is a basic validation method which will be used to validate username and password
  bool validate() {
    if (usernameOrEmailEditingController.text.isEmpty ||
        passwordEditingController.text.isEmpty) {
      if (mounted) {
        setState(() {
          usernameOrEmailErrorText =
              usernameOrEmailEditingController.text.isEmpty
                  ? 'Please enter the username or email'
                  : null;
          passwordErrorText = passwordEditingController.text.isEmpty
              ? 'Please enter the password'
              : null;
        });
      }
      return false;
    }
    return true;
  }

  // This bool controls the loading state of the login screen
  bool isLoading = false;

  // Dispose text editing controllers
  @override
  void dispose() {
    usernameOrEmailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (contex, authProvider, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 200,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    CustomTextField(
                      enabled: !isLoading,
                      hintText: 'Username or email',
                      errorText: usernameOrEmailErrorText,
                      controller: usernameOrEmailEditingController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Using custom widgets to improve dry code
                    CustomTextField(
                      errorText: passwordErrorText,
                      enabled: !isLoading,
                      controller: passwordEditingController,
                      obscureText: isObscured,
                      hintText: 'Password',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          enableFeedback: false,
                          onTap: toggleObscured,
                          child: Icon(
                            isObscured
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : InkWell(
                            enableFeedback: false,
                            borderRadius: BorderRadius.circular(10),
                            onTap: () async {
                              if (validate()) {
                                log(authProvider.isConnected.toString());
                                if (authProvider.isConnected) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await authProvider
                                      .loginUser(
                                          usernameOrEmailEditingController.text,
                                          passwordEditingController.text)
                                      .then((_) {
                                    if (authProvider.userModel == null) {
                                      setState(() {
                                        usernameOrEmailErrorText = ' ';
                                        passwordErrorText =
                                            'Invalid credentials';
                                        isLoading = false;
                                      });
                                    } else {
                                      if (authProvider.userModel!.hasWallet) {
                                        Navigator.pushReplacementNamed(
                                            context, '/wallet_screen');
                                      } else {
                                        Navigator.pushReplacementNamed(
                                            context, '/create_wallet_screen');
                                      }
                                    }
                                  });
                                } else {
                                  showBlurredDialog(context,
                                      'Please check your internet connectivity');
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  opacity: 0.6,
                                  fit: BoxFit.none,
                                  image:
                                      AssetImage('assets/login_button_bg.png'),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
