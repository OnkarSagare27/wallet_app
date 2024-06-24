class WalletModel {
  final String walletName;
  final String userPin;
  final String network;
  final String publicKey;
  final String secretKey;

  WalletModel({
    required this.walletName,
    required this.userPin,
    required this.network,
    required this.publicKey,
    required this.secretKey,
  });

  // Factory constructor for creating a new WalletModel instance from a map.
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      walletName: json['walletName'],
      userPin: json['userPin'],
      network: json['network'],
      publicKey: json['publicKey'],
      secretKey: json['secretKey'],
    );
  }

  // Method to convert a WalletModel instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'walletName': walletName,
      'userPin': userPin,
      'network': network,
      'publicKey': publicKey,
      'secretKey': secretKey,
    };
  }
}
