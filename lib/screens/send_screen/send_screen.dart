import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/screens/send_screen/pincode_screen.dart';
import 'package:wallet_app/widgets/custom_button.dart';
import 'package:wallet_app/widgets/custom_text_field.dart';

import '../wallet_screen/providers/wallet_provider.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  // This bool controls the loading state of the send screen
  bool isLoading = false;
  // Text editing controller for Username and password
  TextEditingController recipientAddressEditingController =
      TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  // These varibales will be used to set or change error text of Recipient Address and Amount text field
  String? recipientAddressErrorText;
  String? amountErrorText;
  bool validate(double bal) {
    if (recipientAddressEditingController.text.isEmpty ||
        amountEditingController.text.isEmpty ||
        double.parse(amountEditingController.text) > bal) {
      if (mounted) {
        setState(() {
          recipientAddressErrorText =
              recipientAddressEditingController.text.isEmpty
                  ? 'Please enter the Recipient Address'
                  : null;
          amountErrorText = amountEditingController.text.isEmpty
              ? 'Please enter the Amount'
              : null;
          if (amountEditingController.text.isNotEmpty) {
            amountErrorText = double.parse(amountEditingController.text) > bal
                ? 'Your available balance is $bal'
                : null;
          }
        });
      }
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, WalletProvider>(
        builder: (context, authProvider, homeProvider, child) {
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
          title: const Text('Send'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Recipient Address',
                errorText: recipientAddressErrorText,
                controller: recipientAddressEditingController,
                suffixIcon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Amount',
                errorText: amountErrorText,
                onChanged: (input) {
                  if (input.isNotEmpty) {
                    if (double.parse(input) > homeProvider.balance) {
                      setState(() {
                        amountErrorText =
                            'Your available balance is ${homeProvider.balance}';
                      });
                    }
                  }
                },
                controller: amountEditingController,
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(
                  Icons.attach_money_outlined,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : CustomButton(
                      onTap: () {
                        if (validate(homeProvider.balance)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PincodeScreen(
                                recipientAddress:
                                    recipientAddressEditingController.text,
                                amount: double.parse(
                                  amountEditingController.text,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      text: 'Send',
                    )
            ],
          ),
        ),
      );
    });
  }
}
