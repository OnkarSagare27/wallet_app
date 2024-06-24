import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/screens/create_wallet_screen/create_wallet_info_screen.dart';
import 'package:wallet_app/screens/create_wallet_screen/create_wallet_screen.dart';
import 'package:wallet_app/screens/create_wallet_screen/providers/create_wallet_provider.dart';

class CreateWalletLayoutScreen extends StatefulWidget {
  const CreateWalletLayoutScreen({super.key});

  @override
  State<CreateWalletLayoutScreen> createState() =>
      _CreateWalletLayoutScreenState();
}

class _CreateWalletLayoutScreenState extends State<CreateWalletLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateWalletProvider>(
        builder: (context, createWalletProvider, child) {
      return Scaffold(
          body: PageView(
        controller: createWalletProvider.pageController,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        // scrollBehavior: const ScrollBehavior(),
        children: const [
          CreateWalletInfoScreen(),
          CreateWalletScreen(),
        ],
      ));
    });
  }
}
