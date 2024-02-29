import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class ChannelInfo {
  final String title;
  final String description;
  final String subscriberCount;

  ChannelInfo({
    required this.title,
    required this.description,
    required this.subscriberCount,
  });

  factory ChannelInfo.fromMap(Map<String, dynamic> map) {
    return ChannelInfo(
      title: map['items'][0]['snippet']['title'],
      description: map['items'][0]['snippet']['description'],
      subscriberCount: map['items'][0]['statistics']['subscriberCount'],
    );
  }
}

class YouTubeApiService {
  final String apiKey;

  YouTubeApiService(this.apiKey);

  Future<ChannelInfo> fetchChannelInfo(String channelName) async {
    String apiUrl = 'https://www.googleapis.com/youtube/v3/channels?'
        'part=snippet,contentDetails,statistics'
        '&forUsername=$channelName'
        '&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      return ChannelInfo.fromMap(responseBody);
    } else {
      throw Exception('Failed to load channel information');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _channelController = TextEditingController();
  final YouTubeApiService _apiService = YouTubeApiService('AIzaSyBF1bM5BTWsNPFClIKDPSzFDCyZmObz8GE');
  ChannelInfo? _channelInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Channel Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _channelController,
              decoration: const InputDecoration(labelText: 'Enter Channel Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String channelName = _channelController.text;
                _fetchChannelInfo(channelName);
              },
              child: const Text('Get Channel Info'),
            ),
            const SizedBox(height: 20),
            _channelInfo != null
                ? _buildInfoBox('Title', _channelInfo!.title): Container(),
            _channelInfo != null
                ? _buildInfoBox(
                    'Description', _channelInfo!.description): Container(),
            _channelInfo != null
                ? _buildInfoBox(
                    'Subscriber Count', _channelInfo!.subscriberCount): Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }

  void _fetchChannelInfo(String channelName) async {
    try {
      ChannelInfo channelInfo = await _apiService.fetchChannelInfo(channelName);
      setState(() {
        _channelInfo = channelInfo;
      });
    } catch (e) {
      print('Error fetching channel information: $e');
    }
  }
}
