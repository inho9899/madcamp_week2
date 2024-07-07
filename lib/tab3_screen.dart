import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

// 생각해봤는데 db에는 아티스트명 말고 그냥 title을 id 값으로만 가져와서 나머지 설명/날짜/기타공지사항 넣는게 나을듯
class Event {
  final String title;
  final String description;  // 공시사항도 뭘 넣어야할지 모르겠음
  final int daysLeft; // 날짜 지정해서 로직 짜야함
  final String detailInfo;

  Event({required this.title, required this.description, required this.daysLeft, required this.detailInfo});
}

class Tab3Screen extends StatelessWidget {
  // 예시 데이터 (DB에서 가져온다고 가정)
  // event_detail_screen 에서 컨테이너에 넣을 사진 추가될 수도 있음
  final List<Event> allEvents = [
    Event(title: '여기서 title 부분에', description: '7/4-5 아티스트1 콘서트', daysLeft: 1, detailInfo: '기타 공지사항: ...'),
    Event(title: '뭘 넣어야할지', description: '8/4-5 아티스트2 콘서트', daysLeft: 31, detailInfo: '기타 공지사항: ...'),
    Event(title: '모르겠음', description: '9/4-5 아티스트3 콘서트', daysLeft: 61, detailInfo: '기타 공지사항: ...'),
    Event(title: '사진 넣을까', description: '10/4-5 아티스트4 콘서트', daysLeft: 91, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트5', description: '11/4-5 아티스트5 콘서트', daysLeft: 121, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트6', description: '12/4-5 아티스트6 콘서트', daysLeft: 151, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트7', description: '1/4-5 아티스트7 콘서트', daysLeft: 181, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트8', description: '2/4-5 아티스트8 콘서트', daysLeft: 211, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트9', description: '3/4-5 아티스트9 콘서트', daysLeft: 241, detailInfo: '기타 공지사항: ...'),
    Event(title: '이벤트10', description: '4/4-5 아티스트10 콘서트', daysLeft: 271, detailInfo: '기타 공지사항: ...'),
  ];

  // 원하는 개수만큼 이벤트를 가져오는 메서드
  List<Event> getLimitedEvents(int count) {
    return allEvents.take(count).toList();
  }

  void _showEventDetails(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailScreen(event: event)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 표시할 이벤트 개수 설정
    final int eventCount = 4;
    final List<Event> events = getLimitedEvents(eventCount);

    return Scaffold(
      appBar: AppBar(
        title: Text('[앱 이름] Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () => _showEventDetails(context, event),
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white, // 회색을 흰색으로 변경
                          ),
                          child: Center(
                            child: Text(
                              event.title,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.description,
                            style: TextStyle(color: Colors.white, fontSize: 16), // 글자 색상을 흰색으로 변경
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Color(0xFFB2E545)),
                            child: Text(
                              'D-${event.daysLeft}',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1), // 각 컨테이너 사이의 간격을 설정
            ],
          );
        },
      ),
    );
  }
}
