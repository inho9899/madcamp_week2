import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Tab2Screen extends StatelessWidget {
  // 예시 데이터 (DB에서 가져온다고 가정)
  final String albumImage = 'assets/images/album_cover.jpeg'; // 앨범 커버 이미지 경로
  final String songTitle = 'DB에서 제목 가져오기'; // 노래 제목
  final String songDescription = 'DB에서 노래설명/아티스트명 가져오기'; // 노래 설명

  void _addToPlaylist() {
    // 플레이리스트에 추가하는 로직
  }

  void _goToPlaylist() {
    // 플레이리스트 탭으로 이동하는 로직
  }

  // 리뷰 작성
  /*
  void _writeReview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('리뷰 작성'),
          content: TextField(
            decoration: InputDecoration(hintText: "리뷰를 입력하세요"),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('저장'),
              onPressed: () {
                // 리뷰를 저장하는 로직
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
*/
  void _writeReview(BuildContext context) {
    double _rating = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('리뷰 작성'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('별점을 선택해주세요'),
                  SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(hintText: "리뷰를 입력하세요"),
                    maxLines: 5,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('저장'),
                  onPressed: () {
                    // 리뷰와 별점을 저장하는 로직
                    // 예: DB로 데이터를 넘기는 코드 추가
                    print('별점: $_rating'); // 추후 DB로 넘기기 위한 로그
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '오늘의 추천 플레이리스트',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // 모서리를 둥글게 설정
              child: Image.asset(
                albumImage,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            songTitle,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 350, // 중앙에 원하는 길이만큼 줄을 긋기 위해 너비 설정
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          SizedBox(height: 5),
          Text(
            songDescription,
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 350, // 중앙에 원하는 길이만큼 줄을 긋기 위해 너비 설정
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _addToPlaylist,
                  child: Row(
                    children: [
                      Image.asset('assets/icons/plus_icon.png', width: 25, height: 25),
                      SizedBox(width: 8),
                      Text(
                        '  플레이리스트에 추가하기',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF89BF0F),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _writeReview(context),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/plus_icon.png', width: 25, height: 25),
                      SizedBox(width: 8),
                      Text(
                        '  리뷰 쓰러 가기',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF89BF0F), // 사용자 지정 색상
                          fontWeight: FontWeight.w800, // 볼드체 설정
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: _goToPlaylist,
                  child: Row(
                    children: [
                      Image.asset('assets/icons/plus_icon.png', width: 25, height: 25),
                      SizedBox(width: 8),
                      Text(
                        '  플레이리스트로 이동',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF89BF0F),
                            fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}