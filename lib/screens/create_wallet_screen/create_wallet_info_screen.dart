import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/screens/create_wallet_screen/providers/create_wallet_provider.dart';

import 'widgets/rectangular_image_with_shadow_border.dart';

class CreateWalletInfoScreen extends StatefulWidget {
  const CreateWalletInfoScreen({super.key});

  @override
  State<CreateWalletInfoScreen> createState() => _CreateWalletInfoScreenState();
}

class _CreateWalletInfoScreenState extends State<CreateWalletInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateWalletProvider>(
        builder: (context, createWalletProvider, child) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.5,
              image: AssetImage('assets/create_wallet_screen_bg.png'),
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to your Wallet, Your wallet is a gateway to the decentralized web. You can use it to store, send, and receive cryptocurrencies.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Expanded(
                      child: Center(
                        child: RectangularImageWithShadowBorder(
                            imagePath: 'assets/logo.png'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        createWalletProvider.pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.bounceInOut);
                      },
                      enableFeedback: false,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFFD700),
                              Color(0xFFF0C300),
                              Color(0xFFFFE135),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Text(
                            'Create Wallet',
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
            ),
          ),
        ),
      );
    });
  }
}
