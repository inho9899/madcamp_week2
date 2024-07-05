import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../utils/auth_service.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginScreen extends StatelessWidget {
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
      HomeScreen();
    } catch (error) {
      print('카카오 로그인 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Id'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthService.login();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Register'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loginWithKakao(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // 카카오톡 버튼 색상
              ),
              child: Text(
                'Login with Kakao',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
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
