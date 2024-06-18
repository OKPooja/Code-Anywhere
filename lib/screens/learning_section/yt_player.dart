import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/colors.dart';

class YouTubePlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String videoDescription;

  const YouTubePlayer({super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  _YouTubePlayerState createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: (){
            Get.back();
          },
        ),
        title: Text(
          '${ widget.videoTitle}',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito'
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: 2000,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      widget.videoDescription,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}