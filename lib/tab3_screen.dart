import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

// Event 클래스 정의
class Event {
  final String imagePath; // 수정된 부분: imageUrl을 imagePath로 변경
  final String description;
  final int daysLeft;
  final String detailInfo;

  Event({
    required this.imagePath, // 수정된 부분: imageUrl을 imagePath로 변경
    required this.description,
    required this.daysLeft,
    required this.detailInfo,
  });
}

class Tab3Screen extends StatelessWidget {
  // 예시 데이터 (DB에서 가져온다고 가정)
  final List<Event> allEvents = [
    Event(
      imagePath: 'assets/images/yoonha.png', // 수정된 부분: imageUrl을 imagePath로 변경하고 경로를 assets 폴더로 설정
      description: '7/13-14 윤하 소극장 콘서트',
      daysLeft: 3,
      detailInfo: '위치 : 서울 블루스퀘어 마스터카드홀',
    ),
    Event(
      imagePath: 'assets/images/ive.png',
      description: '8/10-11 아이브(IVE) 앙코르 콘서트',
      daysLeft: 31,
      detailInfo: '위치 : KSPO DOME',
    ),
    Event(
      imagePath: 'assets/images/christopher.png',
      description: '8/24-25 Christopher 내한 공연',
      daysLeft: 45,
      detailInfo: '위치 : 잠실 실내체육관',
    ),
    Event(
      imagePath: 'assets/images/iu.png',
      description: '9/21-22 아이유 앵콜 콘서트',
      daysLeft: 73,
      detailInfo: '위치 : 서울 월드컵경기장',
    ),
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
        title: Text(
          '[앱 이름] Event',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              event.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              event.description,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Color(0xFFB2E545)),
                            child: Text(
                              'D-${event.daysLeft}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
