// This class represents a User of the app
class UserModel {
  int balance;
  String token;
  String username;
  String email;
  String firstName;
  String lastName;
  bool isVerified;
  String role;
  String? network;
  String ownerId;
  String walletAddress;
  bool hasWallet;
  DateTime lastLogin;
  String profilePictureUrl;

  UserModel({
    required this.balance,
    required this.token,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.role,
    required this.ownerId,
    required this.walletAddress,
    required this.hasWallet,
    required this.lastLogin,
    required this.profilePictureUrl,
    this.network,
  });

  // Factory constructor for creating a new UserModel instance from a map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      balance: json['balance'] as int,
      token: json['token'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isVerified: json['isVerified'] as bool,
      role: json['role'] as String,
      ownerId: json['owner_id'] as String,
      walletAddress: json['wallet_address'] as String,
      hasWallet: json['has_wallet'] as bool,
      lastLogin: DateTime.parse(json['last_login'] as String),
      profilePictureUrl: json['profile_picture_url'] as String,
    );
  }

  // Method for converting a UserModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'token': token,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'isVerified': isVerified,
      'role': role,
      'owner_id': ownerId,
      'wallet_address': walletAddress,
      'has_wallet': hasWallet,
      'last_login': lastLogin.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
      'network': network
    };
  }
}
