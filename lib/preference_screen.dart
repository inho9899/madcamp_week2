import 'package:flutter/material.dart';
import 'home_screen.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final List<Map<String, String>> preferences = [
    {'image': 'assets/images/image1.jpeg', 'text': 'Pop'},
    {'image': 'assets/images/image2.jpeg', 'text': 'Hiphop'},
    {'image': 'assets/images/image3.jpeg', 'text': 'R&B'},
    {'image': 'assets/images/image4.jpeg', 'text': 'OST'},
    {'image': 'assets/images/image5.jpeg', 'text': 'Ballade'},
    {'image': 'assets/images/image6.jpeg', 'text': 'Dance'},
  ];

  final Set<String> selectedPreferences = Set();

  void _toggleSelection(String text) {
    setState(() {
      if (selectedPreferences.contains(text)) {
        selectedPreferences.remove(text);
      } else {
        selectedPreferences.add(text);
      }
    });
  }

  // HomeScreen 으로 돌아가기
  void _completeSurvey(BuildContext context) {
    if (selectedPreferences.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('한 개 이상의 장르를 선택해주세요'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // 여기에 선택한 취향을 DB에 저장하는 로직을 추가


    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(kakaoUser: null, naverAccount: null)),
          (Route<dynamic> route) => false,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      backgroundColor: Colors.black, // 배경색을 검정으로 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                '회원가입이 거의 다 완료되었어요',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 텍스트 색상 흰색으로 설정
                ),
              ),
            ),
            Center(
              child: Text(
                '자신의 취향을 모두 골라주세요!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 텍스트 색상 흰색으로 설정
                ),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: preferences.map((preference) {
                  final isSelected = selectedPreferences.contains(preference['text']);
                  return GestureDetector(
                    onTap: () => _toggleSelection(preference['text']!),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(preference['image']!),
                              fit: BoxFit.cover,
                              colorFilter: isSelected
                                  ? ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                                  : null,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 10,
                          child: Text(
                            preference['text']!,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => _completeSurvey(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    '설문 완료하기 >',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white, // 텍스트 색상 흰색으로 설정
                      //decoration: TextDecoration.underline,
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