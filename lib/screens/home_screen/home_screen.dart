import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/screens/home_screen/providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This bool controls the loading state of the home screen
  bool isLoading = true;
  late AuthProvider authProv;
  late HomeProvider homeProv;
  @override
  void initState() {
    authProv = Provider.of<AuthProvider>(context, listen: false);
    homeProv = Provider.of<HomeProvider>(context, listen: false);
    homeProv
        .getUserBalance(authProv.userModel!.walletAddress, 'devnet',
            authProv.userModel!.token)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, HomeProvider>(
        builder: (context, authProvider, homeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wallet'),
          titleTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "\$${homeProvider.balance}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Text(
                                  authProvider.userModel!.walletAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                enableFeedback: false,
                                onTap: () {},
                                child: const Icon(
                                  Icons.copy_rounded,
                                  size: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {},
                      enableFeedback: false,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/create_wallet_screen_bg.png'),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'Send',
                            style: TextStyle(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(1),
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
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
