import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Video extends StatelessWidget {
  final String videoUrl;
  final String title;

  const Video({
    Key? key,
    required this.videoUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchYouTubeVideo(videoUrl);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2.0,
              color: Colors.black,
            ),
          ),
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  // Use YouTube video thumbnail URL
                  'https://img.youtube.com/vi/${Uri.parse(videoUrl).queryParameters['v']}/0.jpg',
                  // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$title Trailer',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchYouTubeVideo(String videoUrl) async {
    if (await canLaunch(videoUrl)) {
      await launch(videoUrl);
    } else {
      // Handle errors, e.g., show an error message
      print('Could not launch $videoUrl');
    }
  }
}
