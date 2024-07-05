import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'e6f2b28d149730b2e8c55ba532d18474'); // YOUR_KAKAO_APP_KEY를 실제 네이티브 앱 키로 변경하세요
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  Future<void> _loginWithKakao(BuildContext context) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패: $error');
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오 계정으로 로그인 성공');
        } catch (error) {
          print('카카오 계정으로 로그인 실패: $error');
        }
      }
      // 로그인 성공 후 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInfoPage(user: user)),
      );
    } catch (error) {
      print('카카오 로그인 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kakao Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _loginWithKakao(context),
          child: Text('Login with Kakao'),
        ),
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final User user;

  UserInfoPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ID: ${user.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nickname: ${user.kakaoAccount?.profile?.nickname}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${user.kakaoAccount?.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            if (user.kakaoAccount?.profile?.thumbnailImageUrl != null)
              Image.network(user.kakaoAccount!.profile!.thumbnailImageUrl!)
          ],
        ),
      ),
    );
  }
}
