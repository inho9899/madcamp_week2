// 로그인 완료 후 tab1,2,3 나오도록

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'tab1_screen.dart';
import 'tab2_screen.dart';
import 'tab3_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? kakaoUser;
  final NaverAccountResult? naverAccount;

  HomeScreen({this.kakaoUser, this.naverAccount});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Tab1Screen(),
      Tab2Screen(),
      Tab3Screen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black, // 전체 배경색을 검정으로 설정
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tab 3',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black, // 네비게이션 바 배경색을 검정으로 설정
        selectedItemColor: Colors.white, // 선택된 아이템 색상을 흰색으로 설정
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상을 회색으로 설정
        type: BottomNavigationBarType.fixed, // 네비게이션 바 타입을 fixed로 설정
      ),
    );
  }
}
