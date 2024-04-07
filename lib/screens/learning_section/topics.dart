import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/learning_section/yt_player.dart';
import 'package:project/utils/colors.dart';

class Topics extends StatefulWidget {
  final String category;

  const Topics({Key? key, required this.category}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  final int _progress = 0;

  final Map<String, List<Map<String, dynamic>>> _topicsByCategory = {
    'Arrays': [
      {
        'topic': 'Array Basics',
        'link': 'https://www.youtube.com/watch?v=NTHVTY6w2Co'
      },
      {
        'topic': 'Multidimensional Arrays',
        'link': 'https://www.youtube.com/watch?v=18Zt5I4S45o'
      },
      {
        'topic': 'Array Operations',
        'link': 'https://www.youtube.com/watch?v=Bnjbun-hiBk'
      }
    ],
    'Strings': [
      {
        'topic': 'String Basics',
        'link': 'https://www.youtube.com/watch?v=ci9Ll2mLrFk'
      },
      {
        'topic': 'String Manipulation',
        'link': 'https://www.youtube.com/watch?v=i5jwOr4igqM'
      },
      {
        'topic': 'String Formatting',
        'link': 'https://www.youtube.com/watch?v=awQsIcfUb_c'
      }
    ],
  };


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topics = _topicsByCategory[widget.category] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: (){
            Get.back();
          },
        ),
        title: Text(
            '${widget.category}',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito'
            ),
        ),
      ),
      body: Column(
        children: [
          // LinearProgressIndicator(
          //   value: (_progress) / topics.length,
          //   backgroundColor: Colors.grey[300],
          //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(topics[index]['topic']),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> YouTubePlayer(videoUrl: topics[index]['link'].toString(), videoTitle: topics[index]['topic'].toString(), videoDescription: "")));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
