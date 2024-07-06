import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'login_screen.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'e6f2b28d149730b2e8c55ba532d18474'); // YOUR_KAKAO_APP_KEY를 실제 네이티브 앱 키로 변경하세요
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao and Naver Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(), //시작 페이지를 로그인 페이지로
    );
  }
}