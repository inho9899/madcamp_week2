import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tab3_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;
  final String point;
  final String uid;
  final int index;

  EventDetailScreen({required this.event, required this.point, required this.uid, required this.index});

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
            Container(
              width: 280,
              height: 400, // 원하는 높이로 설정
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ClipRRect(
                child: Image.asset(
                  event.imagePath, // 이미지 경로를 사용하여 이미지 표시
                ),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.detailInfo,
                style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold), // 글자 색상을 흰색으로 변경
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '보유 포인트: $point', // 예시로 고정된 포인트 값, 나중에 유저마다 다르게 보여야함
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '차감될 포인트: 500', // 예시로 고정된 포인트 값
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 280, // 원하는 너비로 설정
              height: 50, // 원하는 높이로 설정
              child: ElevatedButton(
                onPressed: () async{
                  print("eid : $index");

                  final response = await http.post(
                    Uri.parse('http://172.10.7.116/buy_event'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, dynamic>{
                      'uid': uid,
                      'eid': index,
                      'coin' : point
                    }),
                  );

                  print("${response.statusCode}");

                  if(response.statusCode == 200){
                    // int newpoint = int.parse(point) - 500;
                    // 포인트 차감 로직 추가
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('포인트를 사용했습니다!!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Navigator.of(context).pop("bye");
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('포인트가 부족합니다'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }


                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // 패딩을 제거
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '참여하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // 원하는 글자 크기
                        fontWeight: FontWeight.bold,// 볼드체 설정
                      ),
                    ),
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
