// 전체 로그인 화면(카카오, 네이버, 아이디로 로그인)

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'id_login_screen.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginPage extends StatelessWidget {
  // 카카오톡 로그인 처리
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(kakaoUser: user)),
      );
    } catch (error) {
      print('카카오 로그인 실패: $error');
    }
  }

  // 네이버 로그인 처리
  Future<void> _loginWithNaver(BuildContext context) async {
    try {
      NaverLoginResult result = await FlutterNaverLogin.logIn();
      if (result.status == NaverLoginStatus.loggedIn) {
        print('네이버로 로그인 성공: ${result.account}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(naverAccount: result.account)),
        );
      } else {
        print('네이버 로그인 실패: ${result.errorMessage}');
      }
    } catch (error) {
      print('네이버 로그인 실패: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _loginWithKakao(context),
              child: Container(
                width: 200, // 원하는 너비로 설정
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // 모서리 반경을 12로 설정
                  child: Image.asset('assets/images/kakao.png'),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _loginWithNaver(context),
              child: Container(
                width: 200, // 원하는 너비로 설정
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // 모서리 반경을 12로 설정
                  child: Image.asset('assets/images/naver.png'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150, // 원하는 너비로 설정
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('또는'),
                ),
                Container(
                  width: 150, // 원하는 너비로 설정
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: 200,
              height:50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IDLoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 모서리 반경을 12로 설정
                  ),
                ),
                child: Text(
                  '아이디로 로그인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Frank Ruhl Libre',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 100), // 아이디로 로그인 버튼 아래 공간 추가
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()), // 회원가입 페이지로 이동
                );
              },
              child: Text(
                '회원가입 하러가기 >',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.underline, // 밑줄 추가
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
