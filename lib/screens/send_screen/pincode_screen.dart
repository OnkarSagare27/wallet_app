import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/screens/wallet_screen/providers/wallet_provider.dart';
import 'package:wallet_app/services/api_services.dart';
import 'package:wallet_app/widgets/custom_button.dart';

import '../../widgets/custom_dilog_box.dart';
import '../../widgets/custom_text_field.dart';

class PincodeScreen extends StatefulWidget {
  const PincodeScreen(
      {super.key, required this.recipientAddress, required this.amount});
  final String recipientAddress;
  final double amount;

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  // Text editing controller for Pincode
  TextEditingController pincodeEditingController = TextEditingController();

  // This varibales will be used to set or change error text of Pincode text field
  String? pincodeErrorText;

  // This is a basic validation method which will be used to validate Pincode
  bool validate() {
    setState(() {
      pincodeErrorText = null;
    });

    if (pincodeEditingController.text.isEmpty) {
      if (mounted) {
        setState(() {
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

  // This bool controls the loading state of the pincode screen

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, WalletProvider>(
        builder: (context, authProvider, walletPorvider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          title: const Text('Enter Pincode'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
          child: Column(
            children: [
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
                hintText: '6-digit numeric pin',
                enabled: !isLoading,
                keyboardType: TextInputType.number,
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
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : CustomButton(
                      onTap: () {
                        if (validate()) {
                          if (authProvider.isConnected) {
                            setState(() {
                              isLoading = true;
                            });
                            ApiServices.transferBalance(
                                    widget.recipientAddress,
                                    'devnet',
                                    authProvider.userModel!.walletAddress,
                                    widget.amount,
                                    pincodeEditingController.text,
                                    authProvider.userModel!.token)
                                .then((res) {
                              setState(() {
                                isLoading = false;
                              });
                              if (res != null) {
                                if (res['status'] == 'success') {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName('/wallet_screen'));
                                }
                                showBlurredDialog(context, res['message']);
                              } else {
                                showBlurredDialog(context,
                                    'Something went wrong, please try again later.');
                              }
                            });
                          }
                        }
                      },
                      text: 'Transfer',
                    )
            ],
          ),
        ),
      );
    });
  }
}
