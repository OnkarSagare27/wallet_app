import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/widgets/custom_text_field.dart';

import '../../widgets/custom_snackbar.dart';
import 'providers/create_wallet_provider.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  // Text editing controller for Wallet name and Pincode
  TextEditingController walletNameEditingController = TextEditingController();
  TextEditingController pincodeEditingController = TextEditingController();

  // These varibales will be used to set or change error text of Wallet name and Pincode text field
  String? walletNameErrorText;
  String? pincodeErrorText;

  // This is a basic validation method which will be used to validate Wallet name and Pincode
  bool validate() {
    setState(() {
      walletNameErrorText = null;
      pincodeErrorText = null;
    });

    if (walletNameEditingController.text.isEmpty ||
        pincodeEditingController.text.isEmpty) {
      if (mounted) {
        setState(() {
          walletNameErrorText = walletNameEditingController.text.isEmpty
              ? 'Please enter a Wallet name'
              : null;
          pincodeErrorText = pincodeEditingController.text.isEmpty
              ? 'Please enter a 6-digit pin'
              : null;
        });
      }
      return false;
    }

    String pin = pincodeEditingController.text;
    if (pin.length != 6 || !RegExp(r'^\d{6}$').hasMatch(pin)) {
      if (mounted) {
        setState(() {
          pincodeErrorText = 'Pin must be of 6 numbers';
        });
      }
      return false;
    }

    return true;
  }

  // This bool holds the state of pincode, if true the pincode will be obscure
  bool isObscured = true;

  // Made this fuction to toggle the state of pincode
  void toggleObscured() {
    if (mounted) {
      setState(() {
        isObscured = !isObscured;
      });
    }
  }

  // This bool controls the loading state of the create wallet screen
  bool isLoading = false;

  // Dispose text editing controllers
  @override
  void dispose() {
    walletNameEditingController.dispose();
    pincodeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CreateWalletProvider, AuthProvider>(
        builder: (context, createWalletProvider, authProvider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            enableFeedback: false,
            onPressed: () {
              createWalletProvider.pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          title: const Text('Create Wallet'),
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Wallet Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                hintText: 'Eg. Sam\'s Wallet',
                enabled: !isLoading,
                errorText: walletNameErrorText,
                controller: walletNameEditingController,
              ),
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pincode',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                hintText: 'Eg. 6-digit numeric pin',
                enabled: !isLoading,
                obscureText: isObscured,
                errorText: pincodeErrorText,
                controller: pincodeEditingController,
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
              const Spacer(),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        if (validate()) {
                          if (authProvider.isConnected) {
                            setState(() {
                              isLoading = true;
                            });
                            await authProvider
                                .createUserWallet(
                                    walletNameEditingController.text,
                                    pincodeEditingController.text)
                                .then((_) {
                              if (authProvider.walletModel == null) {
                                setState(() {
                                  walletNameErrorText = ' ';
                                  pincodeErrorText = 'Invalid credentials';
                                  isLoading = false;
                                });
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, '/home_screen');
                              }
                            });
                          } else {
                            showSnackBar(context,
                                'Please check your internet connectivity');
                          }
                        }
                      },
                      enableFeedback: false,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF0C300),
                              Color.fromARGB(255, 191, 166, 25),
                              Color(0xFFF0C300),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
