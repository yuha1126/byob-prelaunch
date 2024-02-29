import 'package:flutter/material.dart';
import 'services/youtubeapi.dart';

class ChannelPage extends StatefulWidget {
  final String channelLink;

  const ChannelPage({super.key, required this.channelLink});

  @override
  _ChannelDataPageState createState() => _ChannelDataPageState();
}

class _ChannelDataPageState extends State<ChannelPage> {
  Map<String, dynamic>? channelData;

  @override
  void initState() {
    super.initState();
    // Fetch channel data when the page is created
    //fetchChannelData();
  }

  // Future<void> fetchChannelData() async {
  //   try {
  //     // Call the fetchChannelData function with your API key and channel ID
  //     Map<String, dynamic> data = await fetchChannel('AIzaSyBF1bM5BTWsNPFClIKDPSzFDCyZmObz8GE', 'YOUR_CHANNEL_ID');
  //     setState(() {
  //       channelData = data;
  //     });
  //   } catch (e) {
  //     // Handle errors, e.g., display an error message to the user
  //     print('Error fetching channel data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Data Page'),
      ),
      body: Center(
        child: channelData != null
            ? Text('Channel Link: ${widget.channelLink}\n${channelData.toString()}')
            : const CircularProgressIndicator(),
      ),
    );
  }
}
