import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        /*
        title: Text('추천 플레이리스트',
        style: TextStyle(color: Colors.white),
        ),
        */
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '추천 플레이리스트',
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: '추천받은 음악을 검색하세요',
                hintStyle: TextStyle(color: Colors.grey), // 힌트 텍스트 색상
                filled: true,
                fillColor: Color(0xFF626161), // 배경 색상
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none, // 기본 테두리 제거
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF626161), // 활성화 상태 테두리 색상
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF626161), // 포커스 상태 테두리 색상
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey, // 아이콘 색상
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // 내용 패딩
              ),
              style: TextStyle(color: Colors.grey), // 입력 텍스트 색상
            ),

            // 여기에 나중에 검색 결과 리스트를 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
