## WalletApp - flutter

A working Wallet application built in Flutter.

## Dependencies
<details>
     <summary> Click to expand </summary>
     
* [http](https://pub.dev/packages/http)
* [provider](https://pub.dev/packages/provider)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [connectivity_plus](https://pub.dev/packages/connectivity_plus)
     
</details>

## Screenshots

Splash Screen               |  Login Screen               | Create Wallet Info Screen               |  Create Wallet Screen
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/splash_screen.png?raw=true)|![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/login_screen.png?raw=true)|![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/create_wallet_info_screen.png?raw=true)|![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/create_wallet_screen.png?raw=true)|

Wallet Screen         |  Send Screen       |   Pincode Screen               
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/wallet_screen.png?raw=true)|![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/send_screen.png?raw=true)|![](https://github.com/OnkarSagare27/wallet_app/blob/master/screenshots/pincode_screen.png?raw=true)|


## Directory Structure
<details>
     <summary> Click to expand </summary>
  
```
|-- lib
|   |-- core
|   |   |-- utils
|   |   |   '-- connectivity_handler.dart
|   |   '-- endpoints.dart
|   |-- models
|   |   |-- user_model.dart
|   |   '-- wallet_model.dart
|   |-- providers
|   |   '-- auth_provider.dart
|   |-- screens
|   |   |-- create_wallet_screen
|   |   |   |-- providers
|   |   |   |   '-- create_wallet_provider.dart
|   |   |   |-- widgets
|   |   |   |   '-- rectangular_image_with_shadow_border.dart
|   |   |   |-- create_wallet_info_screen.dart
|   |   |   |-- create_wallet_layout_screen.dart
|   |   |   '-- create_wallet_screen.dart
|   |   |-- login_screen
|   |   |   '-- login_screen.dart
|   |   |-- send_screen
|   |   |   |-- pincode_screen.dart
|   |   |   '-- send_screen.dart
|   |   |-- splash_screen
|   |   |   '-- splash_screen.dart
|   |   |-- wallet_screen
|   |   |   |-- providers
|   |   |   |   '-- wallet_provider.dart
|   |   |   '-- wallet_screen.dart
|   |-- services
|   |   '-- api_services.dart
|   |-- widgets
|   |   |-- custom_button.dart
|   |   |-- custom_dilog_box.dart
|   |   |-- custom_snackbar.dart
|   |   '-- custom_text_field.dart
|   '-- main.dart
|-- pubspec.yaml
```

</details>