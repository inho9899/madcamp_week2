import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'event_detail_screen.dart';

// Event 클래스 정의
class Event {
  final String imagePath; // 수정된 부분: imageUrl을 imagePath로 변경
  final String description;
  final int daysLeft;
  final String detailInfo;
  final String date;
  final String event;

  Event({
    required this.imagePath, // 수정된 부분: imageUrl을 imagePath로 변경
    required this.description,
    required this.daysLeft,
    required this.detailInfo,
    required this.date,
    required this.event
  });
}

class Tab3Screen extends StatefulWidget {
  final String? token;
  Tab3Screen({this.token});

  @override
  _Tab3ScreenState createState() => _Tab3ScreenState();
}

class _Tab3ScreenState extends State<Tab3Screen> {
  String uid = '';
  String point = '0';

  @override
  void initState() {
    super.initState();
    fetchUidAndPoints();
  }

  Future<void> fetchUidAndPoints() async {
    try {
      final uidResponse = await http.get(
        Uri.parse('http://172.10.7.116:80/get_uid?token=${widget.token}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (uidResponse.statusCode == 200) {
        uid = uidResponse.body;

        try {
          final response = await http.get(
            Uri.parse('http://172.10.7.116:80/points?uid=$uid'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          );
          if (response.statusCode == 200) {
            setState(() {
              point = response.body;
            });
          } else {
            print('Failed to load points');
          }
        } catch (e) {
          print('Error loading points: $e');
        }
      } else {
        print('Failed to load uid');
      }
    } catch (e) {
      print('Error fetching uid: $e');
    }
  }

  // 예시 데이터 (DB에서 가져온다고 가정)
  final List<Event> allEvents = [
    Event(
        imagePath: 'assets/images/yoonha.png', // 수정된 부분: imageUrl을 imagePath로 변경하고 경로를 assets 폴더로 설정
        description: '7/13-14 윤하 소극장 콘서트',
        daysLeft: 3,
        detailInfo: '위치 : 서울 블루스퀘어 마스터카드홀',
        date: '날짜 : 2024-07-13/14',
        event: '이벤트 정보 : 윤하 소극장 콘서트'
    ),
    Event(
        imagePath: 'assets/images/ive.png',
        description: '8/10-11 아이브(IVE) 앙코르 콘서트',
        daysLeft: 31,
        detailInfo: '위치 : KSPO DOME',
        date: '날짜 : 2024-08-10/11',
        event: '이벤트 정보 : 아이브(IVE) 앙코르 콘서트'
    ),
    Event(
        imagePath: 'assets/images/christopher.png',
        description: '8/24-25 Christopher 내한 공연',
        daysLeft: 45,
        detailInfo: '위치 : 잠실 실내체육관',
        date: '날짜 : 2024-08/24-25',
        event: '이벤트 정보 : Christopher 내한 공연'
    ),
    Event(
        imagePath: 'assets/images/iu.png',
        description: '9/21-22 아이유 앵콜 콘서트',
        daysLeft: 73,
        detailInfo: '위치 : 서울 월드컵경기장',
        date: '날짜 : 2024-09/21-22',
        event: '이벤트 정보 : 아이유 앵콜 콘서트'
    ),
  ];

  // 원하는 개수만큼 이벤트를 가져오는 메서드
  List<Event> getLimitedEvents(int count) {
    return allEvents.take(count).toList();
  }

  void _showEventDetails(BuildContext context, Event event, int index) {
    final result = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailScreen(event: event, point: point, uid : uid, index: index)),
    );
    // if (result != null) {
    //   setState(() {
    //     point = result.toString(); // 받은 결과를 포인트로 설정
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // 표시할 이벤트 개수 설정
    final int eventCount = 4;
    final List<Event> events = getLimitedEvents(eventCount);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '  [이벤트] 예정된 행사',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              Image.asset(
                'assets/images/coin.png',
                width : 30,
                height : 30,
                color : Colors.yellowAccent
              ),
              SizedBox(width: 4),
              Text(
                '$point',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: 350,
            color: Colors.black,
            //padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.campaign, color: Colors.pinkAccent),
                Text(
                  '  포인트를 사용하고 콘서트 티켓 받아가세요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _showEventDetails(context, event, index),
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
                                      fontFamily: "Pretendard-SemiBold",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 17,
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
          ),
        ],
      ),
    );
  }
}
