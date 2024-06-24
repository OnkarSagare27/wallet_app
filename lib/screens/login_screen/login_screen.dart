import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';

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

  // This bool controls the loading state of the home screen
  bool isLoading = false;

  void showSnackBar(BuildContext context) {
    // Create a SnackBar
    final snackBar = SnackBar(
      content: const Text('This is a SnackBar!'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Perform some action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Undo action executed')),
          );
        },
      ),
    );

    // Show the SnackBar using ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      'assets/login_logo.png',
                      height: 150,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    TextField(
                      enabled: !isLoading,
                      controller: usernameOrEmailEditingController,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: 'Username or email',
                        errorText: usernameOrEmailErrorText,
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor: const Color(0xff212121),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      enabled: !isLoading,
                      controller: passwordEditingController,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      obscureText: isObscured,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        errorText: passwordErrorText,
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
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor: const Color(0xff212121),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
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
                                      Navigator.pushReplacementNamed(
                                          context, '/home_screen');
                                    }
                                  });
                                } else {
                                  showSnackBar(context);
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
