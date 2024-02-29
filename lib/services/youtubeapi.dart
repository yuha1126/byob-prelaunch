import 'package:http/http.dart' as http;
import 'package:youtube_api/youtube_api.dart';

class YouTubeApiService {
  final String apiKey;

  YouTubeApiService(this.apiKey);

  Future<YT_API> fetchChannelInfo(String channelName) async {
    String apiUrl = 'https://www.googleapis.com/youtube/v3/channels?'
        'part=snippet,contentDetails,statistics'
        '&forUsername=$channelName'
        '&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return YT_API.fromMap(response.body);
    } else {
      throw Exception('Failed to load channel information');
    }
  }
}


