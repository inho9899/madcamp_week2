import 'package:flutter/material.dart';
import 'home_screen.dart';

class IDLoginScreen extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithID(BuildContext context) async {
    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('모든 정보를 입력해주세요'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // 아이디와 비밀번호로 로그인 처리 로직을 여기에 추가
    // ex) 서버와 통신하여 로그인 확인

    // 로그인 성공 시 HomeScreen으로 이동
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(kakaoUser: null, naverAccount: null),
      ),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey, // 화살표 색상
            size: 30, // 화살표 크기
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black, // 배경색을 검정으로 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _idController,
                  style: TextStyle(color: Colors.white), // 입력 텍스트 색상을 흰색으로 설정
                  decoration: InputDecoration(
                    labelText: '아이디',
                    labelStyle: TextStyle(color: Colors.white), // 레이블 텍스트 색상
                    border: UnderlineInputBorder(), // 밑줄 스타일 테두리
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // 기본 밑줄 색상
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // 포커스된 밑줄 색상
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                ),
                SizedBox(height: 8), // TextField와 문구 사이의 간격
                Text(
                  '  아이디를 입력하세요',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white), // 입력 텍스트 색상을 흰색으로 설정
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(color: Colors.white), // 레이블 텍스트 색상
                    border: UnderlineInputBorder(), // 밑줄 스타일 테두리
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // 기본 밑줄 색상
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey
                      ), // 포커스된 밑줄 색상
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 8), // TextField와 문구 사이의 간격
                Text(
                  '   비밀번호를 입력하세요',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _loginWithID(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 모서리 반경을 12로 설정
                  ),
                ),
                child: Text(
                  '로그인',
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
