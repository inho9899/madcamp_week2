import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'playlist_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Musicdetailscreen extends StatefulWidget {
  final String musicName;
  final String artist;
  final String musicId;

  MusicDetailScreen({required this.musicName, required this.artist, required this.musicId});

  @override
  MusicDetailScreenState createState() => _MusicDetailScreenState();
}

class _MusicDetailScreenState extends State<MusicDetailScreenState> {
  String songTitleUrl = 'http://172.10.7.116:80/title';
  String songArtistUrl = 'http://172.10.7.116:80/artist';
  String songUrl = 'http://172.10.7.116:80/music';
  String albumUrl = 'http://172.10.7.116:80/music_image';

  late AudioPlayer _audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  String songTitle = "Loading...";  // 초기 값 설정
  String songArtist = "Loading...";  // 초기 값 설정
  String uid = "0";
  String mid = "0";

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _getuser();
    await _getmusicid();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    await _fetchSongDetails();
    _playMusic(); // 화면이 로드될 때 음악을 자동으로 재생
  }

  Future<void> _getuser() async {
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
  }

  Future<void> _getmusicid() async {
    try {
      final response = await http.get(
        Uri.parse('http://172.10.7.116:80/get_mid?uid=${uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          mid = response.body;
          songTitleUrl = 'http://172.10.7.116:80/title/' + mid;
          songArtistUrl = 'http://172.10.7.116:80/artist/' + mid;
          songUrl = 'http://172.10.7.116:80/music/' + mid;
          albumUrl = 'http://172.10.7.116:80/music_image/' + mid;
        });
      } else {
        print('Failed to load mid');
      }
    } catch (e) {
      print('Error loading mid: $e');
    }
  }