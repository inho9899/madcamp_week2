import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class Tab1Screen extends StatelessWidget {
  final User? kakaoUser;
  final NaverAccountResult? naverAccount;

  Tab1Screen({this.kakaoUser, this.naverAccount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kakaoUser != null) ...[
            Text('Kakao User ID: ${kakaoUser!.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nickname: ${kakaoUser!.kakaoAccount?.profile?.nickname}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${kakaoUser!.kakaoAccount?.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            if (kakaoUser!.kakaoAccount?.profile?.thumbnailImageUrl != null)
              Image.network(kakaoUser!.kakaoAccount!.profile!.thumbnailImageUrl!)
          ],
          if (naverAccount != null) ...[
            Text('Naver User ID: ${naverAccount!.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nickname: ${naverAccount!.nickname}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${naverAccount!.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            if (naverAccount!.profileImage != null)
              Image.network(naverAccount!.profileImage!)
          ],
        ],
      ),
    );
  }
}
