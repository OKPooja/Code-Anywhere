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
        'topic': 'How to use strings in python',
        'link': 'https://youtu.be/Ctqi5Y4X-jA?si=JDj5IqGH9UDnpBtf'
      },
      {
        'topic': 'Intro to strings',
        'link': 'https://youtu.be/3A3TFVDrLCA?si=5d4xRzRGjudgIYe-'
      },
      {
        'topic': 'String methods in Python',
        'link': 'https://youtu.be/0INvoK_T0cE?si=SvVm8PsriO91oavv'
      }
    ],
    'Stacks': [
      {
        'topic': 'Learn stacks',
        'link': 'https://youtu.be/KInG04mAjO0?si=yUDj92oG2JOD3OFw'
      },
      {
        'topic': 'Stack data structure for JAVA',
        'link': 'https://youtu.be/7m1DMYAbdiY?si=3zlXiAtqMln2R2cB'
      },
      {
        'topic': 'Introduction to Stacks',
        'link': 'https://youtu.be/I37kGX-nZEI?si=BmSEbZZsdqPmMXqW'
      }
    ],
    'Queues': [
      {
        'topic': 'Queues in Data structure',
        'link': 'https://youtu.be/yzj0Ch01Exo?si=A-cXIRLijDdOAlQz'
      },
      {
        'topic': 'Introduction to Queue',
        'link': 'https://youtu.be/fbonDkYsKj0?si=7-YUV0MqPC2W3zvs'
      },
      {
        'topic': 'Summary Queues',
        'link': 'https://youtu.be/D6gu-_tmEpQ?si=c_NO_0AVhUU-fHSB'
      }
    ],
    'Sets': [
      {
        'topic': 'Sets in Python',
        'link': 'https://youtu.be/l3kCO8cVA6o?si=JSNCrh_cHqsYV1mp',
      },
      {
        'topic': 'Sets methods',
        'link': 'https://youtu.be/r3R3h5ly_8g?si=IHe6fYY3zOfCg24O'
      },
      {
        'topic': 'Sets Theory Explanation',
        'link': 'https://youtu.be/CTg_To0PwI8?si=uoWrd0IMozq8TaJm'
      }
    ],
    'Maps': [
      {
        'topic': 'Maps function explained',
        'link': 'https://youtu.be/8q2vICb89ys?si=7sQL_8GWnV6iwxoA',
      },
      {
        'topic': 'What are Maps?',
        'link': 'https://youtu.be/UPME8r3SuhA?si=gOWFxiOOqDHspBuw'
      },
      {
        'topic': 'Overview to Maps',
        'link': 'https://youtu.be/LWCN6I1vZoA?si=ojWBMMFqJyohL3XS'
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
            widget.category,
            style: const TextStyle(
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
