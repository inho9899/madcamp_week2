import 'package:flutter/material.dart';
import 'tab1_screen.dart';
import 'tab2_screen.dart';
import 'tab3_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? token;
  final String? login_method;

  HomeScreen({this.token, this.login_method});

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
      Tab2Screen(token : widget.token),
      Tab3Screen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black, // 전체 배경색을 검정으로 설정
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 60.0, // 높이를 60으로 설정
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildNavItem(Icons.person, 0, size: 30.0),
              buildNavItem(Icons.library_music_rounded, 1, size: 30.0),
              buildNavItem(Icons.event_available, 2, size: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index, {double size = 30.0}) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: size, // 아이콘 크기 설정
        ),
      ),
    );
  }
}
