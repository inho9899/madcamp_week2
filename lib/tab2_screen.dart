import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tab2Screen extends StatefulWidget {
  @override
  _Tab2ScreenState createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  List<dynamic> musicList = [];

  Future<void> fetchMusic() async {
    print("Attempting to fetch music...");
    try {
      final response = await http.get(Uri.parse('http://172.10.7.116:80/music'));

      if (response.statusCode == 200) {
        print("Successfully fetched music");
        setState(() {
          musicList = json.decode(response.body);
        });
      } else {
        print("Failed to load music: ${response.statusCode}");
        throw Exception('Failed to load music');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab 2 Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: fetchMusic,
            child: Text('Fetch Music'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(musicList[index]['music_name']),
                  subtitle: Text(musicList[index]['artist']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
