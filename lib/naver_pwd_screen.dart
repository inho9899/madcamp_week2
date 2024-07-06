import 'package:flutter/material.dart';
import 'home_screen.dart';

class NaverPwdScreen extends StatelessWidget {
  final String email; // 네이버 로그인으로 받아온 이메일 등 사용자 정보를 받기 위해 추가

  NaverPwdScreen({required this.email});

  final TextEditingController _passwordController = TextEditingController();

  void _submitPassword(BuildContext context) {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('비밀번호를 입력해주세요'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // 패스워드를 DB에 저장하는 로직을 여기에 추가
    // 예: 서버와 통신하여 비밀번호 저장

    // 저장 후 HomeScreen으로 이동
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(kakaoUser: null, naverAccount: null)),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '개인정보 보호를 위해',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '비밀번호를 설정 해 해주세요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 80), // 문구와 TextField 사이의 간격
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(color: Colors.white),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              obscureText: true,
            ),
            SizedBox(height: 60),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _submitPassword(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Frank Ruhl Libre',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
