import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/screens/create_wallet_screen/create_wallet_layout_screen.dart';
import 'package:wallet_app/screens/create_wallet_screen/providers/create_wallet_provider.dart';
import 'package:wallet_app/screens/wallet_screen/wallet_screen.dart';
import 'package:wallet_app/screens/wallet_screen/providers/wallet_provider.dart';
import 'package:wallet_app/screens/login_screen/login_screen.dart';
import 'package:wallet_app/screens/send_screen/send_screen.dart';
import 'package:wallet_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using services to make the notifcation/status bar transparent
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    // Wrapped MaterialApp with MultiProvider to intialize providers at app initialization
    return MultiProvider(
      // Listted all the providers used throughout the app
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateWalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WalletApp',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
        ),
        // Listed all the screen's routes
        routes: {
          '/login_screen': (context) => const LoginScreen(),
          '/wallet_screen': (context) => const WalletScreen(),
          '/splash_screen': (context) => const SplashScreen(),
          '/create_wallet_screen': (context) =>
              const CreateWalletLayoutScreen(),
          '/send_screen': (context) => const SendScreen(),
        },
        initialRoute: '/splash_screen',
      ),
    );
  }
}
