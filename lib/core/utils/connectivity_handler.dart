import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHandler {
  static final ConnectivityHandler _instance = ConnectivityHandler._();

  ConnectivityHandler._();

  static ConnectivityHandler get instance => _instance;

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Connectivity().onConnectivityChanged;

  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await Connectivity().checkConnectivity();
  }

  Future<bool> isConnected() async {
    final result = await checkConnectivity();
    return result.contains(ConnectivityResult.none);
  }
}
