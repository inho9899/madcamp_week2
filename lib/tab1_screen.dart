import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    required this.event,
  });
}

class Tab1Screen extends StatefulWidget {
  final String? token;
  Tab1Screen({this.token});

  final List<Event> allEvents = [
    Event(
      imagePath: 'assets/images/yoonha.png', // 수정된 부분: imageUrl을 imagePath로 변경하고 경로를 assets 폴더로 설정
      description: '7/13-14 윤하 소극장 콘서트',
      daysLeft: 3,
      detailInfo: '위치 : 서울 블루스퀘어 마스터카드홀',
      date: '날짜 : 2024-07-13/14',
      event: '이벤트 정보 : 윤하 소극장 콘서트',
    ),
    Event(
      imagePath: 'assets/images/ive.png',
      description: '8/10-11 아이브(IVE) 앙코르 콘서트',
      daysLeft: 31,
      detailInfo: '위치 : KSPO DOME',
      date: '날짜 : 2024-08-10/11',
      event: '이벤트 정보 : 아이브(IVE) 앙코르 콘서트',
    ),
    Event(
      imagePath: 'assets/images/christopher.png',
      description: '8/24-25 Christopher 내한 공연',
      daysLeft: 45,
      detailInfo: '위치 : 잠실 실내체육관',
      date: '날짜 : 2024-08/24-25',
      event: '이벤트 정보 : Christopher 내한 공연',
    ),
    Event(
      imagePath: 'assets/images/iu.png',
      description: '9/21-22 아이유 앵콜 콘서트',
      daysLeft: 73,
      detailInfo: '위치 : 서울 월드컵경기장',
      date: '날짜 : 2024-09/21-22',
      event: '이벤트 정보 : 아이유 앵콜 콘서트',
    ),
  ];

  @override
  _Tab1ScreenState createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> {
  String uid = "loading..";
  final String songTitleUrl = 'http://172.10.7.116:80/title';
  final String songArtistUrl = 'http://172.10.7.116:80/artist';

  String songTitle = "Loading...(title)"; // 초기 값 설정
  String songArtist = "Loading...(artist)"; // 초기 값 설정
  double rating = 0.0; // 초기 별점 설정
  Map<DateTime, List<dynamic>> _events = {}; // 캘린더 이벤트 데이터
  List<dynamic> playlist = []; // 플레이리스트 데이터
  List<dynamic> filteredPlaylist = []; // 필터된 플레이리스트 데이터
  List<dynamic> eventIndices = []; // 이벤트 인덱스 리스트

  @override
  void initState() {
    super.initState();
    _fetchSongDetails();
    _fetchAttendanceDates();
    _fetchPlaylist();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final uidResponse = await http.get(
      Uri.parse('http://172.10.7.116:80/get_uid?token=${widget.token}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (uidResponse.statusCode == 200) {
      uid = uidResponse.body;
      final response = await http.get(
        Uri.parse('http://172.10.7.116:80/load_event?uid=$uid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          eventIndices = json.decode(response.body);
          print('$eventIndices');
        });
      } else {
        print('Failed to load events');
      }
    }
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

  Future<void> _fetchAttendanceDates() async {
    try {
      final uidResponse = await http.get(
        Uri.parse('http://172.10.7.116:80/get_uid?token=${widget.token}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (uidResponse.statusCode == 200) {
        uid = uidResponse.body;

        final response = await http.get(
          Uri.parse('http://172.10.7.116:80/cals?uid=$uid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print("$data");
          if (data != null && data['date_info'] != null) {
            List<dynamic> dates = data['date_info'];
            setState(() {
              _events = {
                for (var date in dates)
                  DateTime.parse(date).toLocal(): ['출석체크']
              };
              print("$_events");
            });
          } else {
            print('No dates found in response');
          }
        } else {
          print('Failed to load attendance dates');
        }
      } else {
        print('Failed to load uid');
      }
    } catch (e) {
      print('Error loading attendance dates: $e');
    }
  }

  Future<void> _fetchPlaylist() async {
    try {
      final uidResponse = await http.get(
        Uri.parse('http://172.10.7.116:80/get_uid?token=${widget.token}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (uidResponse.statusCode == 200) {
        uid = uidResponse.body;
      }
      try {
        final response = await http.get(
          Uri.parse('http://172.10.7.116:80/load_review?uid=$uid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        if (response.statusCode == 200) {
          setState(() {
            playlist = json.decode(response.body);
            print("$playlist");
            filteredPlaylist = playlist;
          });
        } else {
          print('Failed to load playlist');
        }
      } catch (e) {
        print('Error loading playlist: $e');
      }
    } catch (e) {
      print('Failed to load uid');
    }
  }

  void _checkAttendance(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('http://172.10.7.116:80/get_uid?token=${widget.token}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          uid = response.body;
        });
      } else {
        print('Failed to load uid');
      }
    } catch (e) {
      print('Error loading uid: $e');
    }

    final response = await http.post(
      Uri.parse('http://172.10.7.116:80/attendence'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'uid': uid,
      }),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('포인트가 지급되었습니다.'),
          duration: Duration(seconds: 1),
        ),
      );
      _fetchAttendanceDates(); // 출석 체크 후 날짜 정보 갱신
    }
    if (response.statusCode == 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오늘은 이미 출석을 하였습니다.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Widget _buildEventMarker(DateTime date, dynamic event) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          width: 7.0,
          height: 7.0,
        ),
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
                      titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
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
                    eventLoader: (day) {
                      return _events[DateTime(day.year, day.month, day.day)] ??
                          [];
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return _buildEventMarker(date, events);
                        }
                        return Container();
                      },
                    ),
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
                      itemCount: eventIndices.length, // 예정된 활동 개수
                      itemBuilder: (context, index) {
                        var event = widget.allEvents[eventIndices[index]['event_id']];
                        return ListTile(
                          leading: Image.asset(
                            event.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            event.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text(
                            '${event.date}\n${event.detailInfo}',
                            style: TextStyle(
                              fontSize: 14,
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
                    itemCount: filteredPlaylist.length, // 작성한 리뷰 개수
                    itemBuilder: (context, index) {
                      var review = filteredPlaylist[index];
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
                                  Image.network(
                                    "http://172.10.7.116:80/music_image/" +
                                        review['music_id'].toString(),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 35.0),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review['music_name'] ??
                                            'Unknown Title',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        review['artist'] ?? 'Unknown Artist',
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
                                  initialRating:
                                  review['rate']?.toDouble() ?? 0.0, // 리뷰의 별점 값
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25.0, // 별 크기를 줄입니다.
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
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
