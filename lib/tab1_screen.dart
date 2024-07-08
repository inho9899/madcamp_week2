import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Tab1Screen extends StatelessWidget {
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
                  width: 400,
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
                  '캘린더',
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
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey[900], // 더 어두운 배경 색상
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
                '예정된 활동',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 지정된 색상으로 변경
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 3, // 예정된 활동 개수
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color : Color(0xFFD6D6D6), // 지정된 색상으로 변경
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        '포인트 사용해서 얻은 활동 리스트업 (스크롤되게)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                '나의 리뷰',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 지정된 색상으로 변경
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 3, // 작성한 리뷰 개수
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD6D6D6), // 지정된 색상으로 변경
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        '작성한 음악 리뷰들 리스트업 (스크롤되게)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}