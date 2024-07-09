import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tab1Screen extends StatefulWidget {
  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> {
  final String songTitleUrl = 'http://172.10.7.116:80/title';
  final String songArtistUrl = 'http://172.10.7.116:80/artist';

  // tab2 에서 받아와야 하는데 일단 임의 설정함
  String songTitle = "Loading...(title)";  // 초기 값 설정
  String songArtist = "Loading...(artist)";  // 초기 값 설정
  double rating = 0.0; // 초기 별점 설정

  @override
  void initState() {
    super.initState();
    _fetchSongDetails();
  }

  Future<void> _fetchSongDetails() async {
    try {
      final titleResponse = await http.get(Uri.parse(songTitleUrl));
      final artistResponse = await http.get(Uri.parse(songArtistUrl));

      if (titleResponse.statusCode == 200 && artistResponse.statusCode == 200) {
        setState(() {
          songTitle = titleResponse.body;
          songArtist = artistResponse.body;
        });
      } else {
        print('Failed to load song details');
      }
    } catch (e) {
      print('Error loading song details: $e');
    }
  }

  void _checkAttendance(BuildContext context) {
    // 출석체크 로직 추가
    // 예: DB에 출석체크 데이터 저장 및 포인트 추가

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('포인트가 지급되었습니다.'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _checkAttendance(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // 패딩 제거
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pinkAccent, Colors.deepPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              '출석체크 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' 캘린더',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 350,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFF393939), // 더 어두운 배경 색상
                  ),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white70),
                      todayTextStyle: TextStyle(color: Colors.black),
                      todayDecoration: BoxDecoration(
                        color: Color(0xD1B5B3B3),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                      formatButtonVisible: false, // '2week' 버튼 숨기기
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      titleCentered: true,
                    ),
                    // 출석체크한 날짜를 표시하는 로직 추가
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                ' 예정된 활동',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 지정된 색상으로 변경
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xFF333333), // 큰 컨테이너의 배경색
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(16.0), // 큰 컨테이너의 패딩
                  child: Container(
                    height: 200,
                    width: 350,
                    child: ListView.builder(
                      itemCount: 4, // 예정된 활동 개수
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.check_circle, color: Colors.green), // 체크 아이콘
                          title: Text(
                            '포인트 사용해서 얻은 활동 리스트업 (스크롤되게)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                ' 나의 리뷰',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 지정된 색상으로 변경
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Container(
                  height: 250,
                  width: 350,
                  child: ListView.builder(
                    itemCount: 3, // 작성한 리뷰 개수
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFF333333), // 카드 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10.0),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xFF1562C3),
                                    child: Icon(Icons.person, color: Colors.white, size:30),
                                  ),
                                  SizedBox(width: 35.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        songTitle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        songArtist,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Transform.translate(
                                offset: Offset(90, 0),
                                child: RatingBar.builder(
                                  initialRating: 4.0, // 기본 별점 값을 여기에서 설정합니다.
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25.0, // 별 크기를 줄입니다.
                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      // rating 값을 업데이트할 수 있는 로직을 여기에 추가합니다.
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
