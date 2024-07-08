import 'package:flutter/material.dart';
import 'preference_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register(BuildContext context) async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('모든 정보를 입력해주세요'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // 회원가입 성공 시 음악 취향 조사 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreferenceScreen(
            name: _nameController.text,
            id: _idController.text,
            password: _passwordController.text,
            token_id: _idController.text,
            type : "NONE"
        ),
      ),
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
                  controller: _nameController,
                  style: TextStyle(color: Colors.white), // 입력 텍스트 색상을 흰색으로 설정
                  decoration: InputDecoration(
                    labelText: '이름',
                    labelStyle: TextStyle(color: Colors.white), // 레이블 텍스트 색상
                    border: UnderlineInputBorder(), // 밑줄 스타일 테두리
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // 기본 밑줄 색상
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38), // 포커스된 밑줄 색상
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                ),
                SizedBox(height: 8), // TextField와 문구 사이의 간격
                Text(
                  '  이름을 입력하세요',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
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
                      borderSide: BorderSide(color: Colors.black38), // 포커스된 밑줄 색상
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
                      borderSide: BorderSide(color: Colors.black38), // 포커스된 밑줄 색상
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
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 모서리 반경을 12로 설정
                  ),
                ),
                child: Text(
                  '회원가입 완료하기',
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
