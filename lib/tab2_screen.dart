import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'playlist_screen.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Tab2Screen extends StatefulWidget {
  @override
  _Tab2ScreenState createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  final String songTitleUrl = 'http://172.10.7.116:80/title';
  final String songArtistUrl = 'http://172.10.7.116:80/artist';
  final String songUrl = 'http://172.10.7.116:80/music';
  final String albumUrl = 'http://172.10.7.116:80/music_image';


  late AudioPlayer _audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  String songTitle = "Loading...";  // 초기 값 설정
  String songArtist = "Loading...";  // 초기 값 설정
  String uid = "1";

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    _fetchSongDetails();
    _playMusic(); // 화면이 로드될 때 음악을 자동으로 재생
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


  Future<void> _initAudioPlayer() async {
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration();
        isPlaying = false;
      });
    });
  }

  void _playMusic() async {
    try {
      await _audioPlayer.setSource(UrlSource(songUrl));
      _audioPlayer.play(UrlSource(songUrl));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('음악 재생 오류: $e');
    }
  }

  void _pauseMusic() {
    try {
      _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      print('음악 재생 오류: $e');
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _seekTo(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  void _addToPlaylist(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('플레이리스트에 추가되었습니다'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _goToPlaylist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaylistScreen()),
    );
  }

  void _writeReview(BuildContext context) {
    double _rating = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xFF2C2C2C),
              title: Text('리뷰 남기기', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('별점을 평가해주세요!', style: TextStyle(color: Colors.white)),
                  ),
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
                ],
              ),
              actions: [
                TextButton(
                  child: Text('취소', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('저장', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    print('별점: $_rating');
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
  void dispose() {
    _audioPlayer.dispose();
    isDialOpen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                '오늘의 추천 플레이리스트',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.rate_review, color: Color(0xFFB6B6B6)),
                          onPressed: () => _writeReview(context),
                        ),
                        SizedBox(width: 170),
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.pink),
                          onPressed: () => _addToPlaylist(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.playlist_add_check_sharp, color: Color(0xFF00E86C)),
                          onPressed: () => _goToPlaylist(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        albumUrl,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      songTitle,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      songArtist,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fast_rewind, color: Colors.grey, size: 40),
                        SizedBox(width: 50),
                        IconButton(
                          icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white),
                          iconSize: 64,
                          onPressed: isPlaying ? _pauseMusic : _playMusic,
                        ),
                        SizedBox(width: 50),
                        Icon(Icons.fast_forward, color: Colors.grey, size: 40),
                      ],
                    ),
                    Slider(
                      value: _position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          _seekTo(value);
                        });
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(_position),
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          formatDuration(_duration),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
