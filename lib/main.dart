import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'utils/auth_service.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'e6f2b28d149730b2e8c55ba532d18474');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthService.isLoggedIn() ? HomeScreen() : LoginScreen(),
    );
  }
}