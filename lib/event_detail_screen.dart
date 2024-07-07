import 'package:flutter/material.dart';
import 'tab3_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.description,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                height: 200, // 높이를 줄임
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    event.detailInfo, // tab3 에서의 detailinfo 가져옴
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.detailInfo,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), // 글자 색상을 흰색으로 변경
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '보유 포인트: 1000', // 예시로 고정된 포인트 값, 나중에 유저마다 다르게 보여야함
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '차감될 포인트: 200', // 예시로 고정된 포인트 값
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 250, // 원하는 너비로 설정
              height: 50, // 원하는 높이로 설정
              child: ElevatedButton(
                onPressed: () {
                  // 포인트 차감 로직 추가
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('포인트가 차감되었습니다.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB2E545),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '참여하기',
                  style: TextStyle(
                    fontSize: 18, // 원하는 글자 크기
                    fontWeight: FontWeight.bold, // 볼드체 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
