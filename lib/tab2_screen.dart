import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'playlist_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
        content: Text('Added to playlist'),
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
              title: Text('Write a Review', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Please select a rating', style: TextStyle(color: Colors.white)),
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
                  child: Text('Cancel', style: TextStyle(color: Colors.tealAccent)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save', style: TextStyle(color: Colors.tealAccent)),
                  onPressed: () {
                    print('Rating: $_rating');
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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '오늘의 추천 플레이리스트',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                songDescription,
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white),
                    iconSize: 64,
                    onPressed: isPlaying ? _pauseMusic : _playMusic,
                  ),
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
                activeColor: Color(0xFFFFFFFF),
                inactiveColor: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(_position),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    formatDuration(_duration),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        openCloseDial: isDialOpen,
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Color(0xFF1C63BF).withOpacity(0.8),
        spaceBetweenChildren: 10.0,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.playlist_add, color: Colors.white),
            backgroundColor: Color(0xFF11228E),
            label: '플레이리스트에 추가',
            labelStyle: TextStyle(color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => _addToPlaylist(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.rate_review, color: Colors.white),
            backgroundColor: Color(0xFF11228E),
            label: '리뷰쓰기',
            labelStyle: TextStyle(color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => _writeReview(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.playlist_add_check, color: Colors.white),
            backgroundColor: Color(0xFF11228E),
            label: '플레이리스트로 이동',
            labelStyle: TextStyle(color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => _goToPlaylist(context),
          ),
        ],
      ),
    );
  }
}
