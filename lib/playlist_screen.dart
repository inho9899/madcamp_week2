import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaylistScreen extends StatefulWidget {
  final String? uid;

  PlaylistScreen({this.uid});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  String albumUrl = "loading...";

  List<dynamic> playlist = [];
  List<dynamic> filteredPlaylist = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPlaylist();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPlaylist() async {
    try {
      final response = await http.get(
        Uri.parse('http://172.10.7.116:80/load_playlist?uid=${widget.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          playlist = json.decode(response.body);
          filteredPlaylist = playlist;
        });
      } else {
        print('Failed to load playlist');
      }
    } catch (e) {
      print('Error loading playlist: $e');
    }
  }

  void _onSearchChanged() {
    _filterPlaylist(searchController.text);
  }

  void _filterPlaylist(String query) {
    setState(() {
      filteredPlaylist = playlist.where((item) {
        final musicNameLower = (item['music_name'] ?? '').toLowerCase();
        final artistLower = (item['artist'] ?? '').toLowerCase();
        final searchLower = query.toLowerCase();
        return musicNameLower.contains(searchLower) || artistLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '플레이리스트',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: '추천받은 음악을 검색하세요',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF626161),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF626161),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Color(0xFF626161),
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
              ),
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlaylist.length,
                itemBuilder: (context, index) {
                  final item = filteredPlaylist[index];
                  return ListTile(
                    leading: Image.network(
                      "http://172.10.7.116:80/music_image/" + item['music_id'].toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item['music_name'] ?? 'Unknown Title',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      item['artist'] ?? 'Unknown Artist',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
