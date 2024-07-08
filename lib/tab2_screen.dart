import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'playlist_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class Tab2Screen extends StatefulWidget {
  @override
  _Tab2ScreenState createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  final String albumImage = 'assets/images/album_cover.jpeg';
  final String songTitle = 'DB에서 제목 가져오기';
  final String songDescription = 'DB에서 아티스트명 가져오기';
  final String songUrl = 'http://172.10.7.116:80/music';

  late AudioPlayer _audioPlayer;
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
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
      print('Error playing audio: $e');
    }
  }

  void _pauseMusic() {
    try {
      _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      print('Error pausing audio: $e');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '오늘의 추천 플레이리스트',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                songDescription,
                style: TextStyle(fontSize: 17, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    iconSize: 40,
                    onPressed: isPlaying ? _pauseMusic : _playMusic,
                  ),
                  Expanded(
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          _seekTo(value);
                        });
                      },
                      activeColor: Colors.red,
                      inactiveColor: Colors.white,
                    ),
                  ),
                  Text(
                    '${formatDuration(_position)} / ${formatDuration(_duration)}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _addToPlaylist(context),
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
                              color: Color(0xFF89BF0F),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _goToPlaylist(context),
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
        ),
      ),
    );
  }
}
