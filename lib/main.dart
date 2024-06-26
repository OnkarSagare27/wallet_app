import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/providers/auth_provider.dart';
import 'package:wallet_app/screens/create_wallet_screen/create_wallet_layout_screen.dart';
import 'package:wallet_app/screens/create_wallet_screen/providers/create_wallet_provider.dart';
import 'package:wallet_app/screens/home_screen/home_screen.dart';
import 'package:wallet_app/screens/home_screen/providers/home_provider.dart';
import 'package:wallet_app/screens/login_screen/login_screen.dart';
import 'package:wallet_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateWalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallet App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
        ),
        routes: {
          '/login_screen': (context) => const LoginScreen(),
          '/home_screen': (context) => const HomeScreen(),
          '/splash_screen': (context) => const SplashScreen(),
          '/create_wallet_screen': (context) =>
              const CreateWalletLayoutScreen(),
        },
        initialRoute: '/splash_screen',
      ),
    );
  }
}
