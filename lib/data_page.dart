import 'package:flutter/material.dart';
import 'channel_page.dart';

class ChannelInput extends StatefulWidget {
  const ChannelInput({Key? key}) : super(key: key);

  @override
  _ChannelInputState createState() => _ChannelInputState();

  static GlobalKey<_ChannelInputState> inputKey = GlobalKey<_ChannelInputState>();
}

class _ChannelInputState extends State<ChannelInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Enter YouTube Channel Link',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  String getChannelLink() {
    return _controller.text;
  }
}

class DataPage extends StatelessWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('YouTube Channel Analyzer'),
        ),
        body: Column(
          children: [
            ChannelInput(key: ChannelInput.inputKey), // Use the key here
            ElevatedButton(
              onPressed: () {
                String channelLink = ChannelInput.inputKey.currentState!.getChannelLink();
                // Check if the link is valid (you can add more validation logic)
                if (isValidChannelLink(channelLink)) {
                  // Navigate to the new page with the channel link
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChannelPage(channelLink: channelLink),
                    ),
                  );
                } else {
                  // Handle invalid link (e.g., show an error message)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Invalid channel link. Please enter a valid YouTube channel link.'),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                }
              },
              child: const Text('Analyze Channel'),
            ),
            // Add widgets to display channel data here
          ],
        ),
      ),
    );
  }

  // Function to check if the channel link is valid
  bool isValidChannelLink(String channelLink) {
    return true;
  }
}
